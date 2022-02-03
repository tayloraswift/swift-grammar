public 
struct ParsingError<Index>:TraceableError, CustomStringConvertible 
{
    public 
    struct Frame 
    {
        let index:Index 
        let rule:Any.Type 
        let construction:Any.Type 
    }
    public static 
    var namespace:String 
    {
        "parsing error"
    }
    public 
    let problem:Error, 
        index:Index,
        trace:[Frame]
    public 
    init(at index:Index, because problem:Error, trace:[Frame])
    {
        self.problem    = problem
        self.index      = index 
        self.trace      = trace
    }
    public 
    var context:[String] 
    {
        trace.map 
        {
            if $0.construction is Void.Type
            {
                return "while validating pattern '\($0.rule)'"
            }
            else 
            {
                return "while parsing value of type '\($0.construction)' by rule '\($0.rule)'"
            }
        }
    } 
    public 
    var next:Error? 
    {
        self.problem 
    }
    
    static 
    func annotate<Background>(_ range:Range<Index>, on background:Background, 
        line render:(Background.SubSequence) -> String, 
        newline predicate:(Background.Element) -> Bool) 
        -> String 
        where Background:BidirectionalCollection, Background.Index == Index
    {
        // `..<` means this will print the previous line if the problematic 
        // index references the newline itself
        let start:Index         = background[..<range.lowerBound].lastIndex (where: predicate) ?? background.startIndex
        let   end:Index         = background[range.lowerBound...].firstIndex(where: predicate) ?? background.endIndex
        let beginning:String    = render(background[start..<range.lowerBound].dropFirst()), 
            middle:String
        let line:String
        if range.upperBound < end 
        {
            middle  = render(background[range])
            line    = beginning + middle + render(background[range.upperBound..<end])
        }
        else 
        {
            middle  = render(background[range.lowerBound..<end])
            line    = beginning + middle 
        }
        return 
            """
            \(line)
            \(String.init(repeating: " ", count: beginning.count))^\(String.init(repeating: "~", count: middle.count).dropLast())
            """
    }
    public 
    func annotate<Background>(source background:Background, 
        line:(Background.SubSequence) -> String, newline:(Background.Element) -> Bool) 
        -> String 
        where Background:BidirectionalCollection, Background.Index == Index
    {
        """
        \(String.init(reflecting: type(of: self.problem))): \(self.problem)
        \(Self.annotate(background.index(before: self.index) ..< self.index, on: background, line: line, newline: newline))
        \(self.trace.map
        {
            (frame:Frame) in
            
            let heading:String 
            if frame.construction is Void.Type
            {
                heading = "note: expected pattern '\(String.init(reflecting: frame.rule))'"
            }
            else 
            {
                heading = "note: while parsing value of type '\(String.init(reflecting: frame.construction))' by rule '\(String.init(reflecting: frame.rule))'"
            }
            return "\(heading)\n\(Self.annotate(frame.index ..< self.index, on: background, line: line, newline: newline))"
        }.reversed().joined(separator: "\n"))
        """
    }
}
public 
protocol ParsingRule 
{
    associatedtype Location
    associatedtype Terminal 
    associatedtype Construction
    
    static 
    func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) 
        throws -> Construction
        where   Diagnostics:ParsingDiagnostics, 
                Diagnostics.Source.Index == Location, 
                Diagnostics.Source.Element == Terminal
}
public
protocol ParsingDiagnostics 
{
    associatedtype Source where Source:Collection 
    associatedtype Breadcrumb 
    
    init()
    
    mutating 
    func push<Rule, Construction>(index:Source.Index, for _:Construction.Type, by _:Rule.Type) 
        -> Breadcrumb
    mutating 
    func pop()
    mutating 
    func reset(index:inout Source.Index, to:Breadcrumb, because:inout Error) 
}
public 
enum Grammar 
{
    @frozen public 
    struct NoDiagnostics<Source>:ParsingDiagnostics where Source:Collection
    {
        @inlinable public 
        init() 
        {
        }
        // force inlining because these functions ignore most of their inputs, and 
        // don’t contain many instructions (if any)
        @inline(__always)
        @inlinable public 
        func push<Rule, Construction>(index:Source.Index, for _:Construction.Type, by _:Rule.Type) 
            -> Source.Index
        {
            index
        }
        @inline(__always)
        @inlinable public 
        func pop()
        {
        }
        @inline(__always)
        @inlinable public 
        func reset(index:inout Source.Index, to breadcrumb:Source.Index, because _:inout Error) 
        {
            index = breadcrumb 
        }
    }
    public 
    struct DefaultDiagnostics<Source>:ParsingDiagnostics where Source:Collection
    {
        private 
        var stack:[ParsingError<Source.Index>.Frame], 
            frontier:ParsingError<Source.Index>?
        public 
        init() 
        {
            self.stack      = []
            self.frontier   = nil 
        }
        public mutating 
        func push<Rule, Construction>(index:Source.Index, for _:Construction.Type, by _:Rule.Type)
        {
            self.stack.append(.init(index: index, rule: Rule.self, construction: Construction.self))
        }
        public mutating 
        func pop()
        {
            self.stack.removeLast()
        }
        public mutating 
        func reset(index:inout Source.Index, to _:Void, because error:inout Error)
        {
            defer 
            {
                index = self.stack.removeLast().index 
            }
            if  error is ParsingError<Source.Index> 
            {
                return 
            }
            if let diagnostic:ParsingError<Source.Index> = self.frontier, index < diagnostic.index
            {
                // we did not make it as far as the previous most-successful parse 
                error           = diagnostic 
            }
            else 
            {
                let diagnostic:ParsingError<Source.Index> = .init(at: index, 
                    because: error, trace: self.stack) 
                self.frontier   = diagnostic 
                error           = diagnostic
            }
        }
    }
}
@frozen
public 
struct ParsingInput<Diagnostics> where Diagnostics:ParsingDiagnostics
{
    public  
    let source:Diagnostics.Source
    public 
    var index:Diagnostics.Source.Index 
    public 
    var diagnostics:Diagnostics
    public 
    init(_ source:Diagnostics.Source)
    {
        self.source         = source 
        self.index          = source.startIndex 
        self.diagnostics    = .init()
    }
    @inlinable public 
    subscript(_ index:Diagnostics.Source.Index) -> Diagnostics.Source.Element 
    {
        self.source[index]
    }
    @inlinable public 
    subscript<Indices>(_ range:Indices) -> Diagnostics.Source.SubSequence 
        where Indices:RangeExpression, Indices.Bound == Diagnostics.Source.Index 
    {
        self.source[range.relative(to: self.source)]
    }
    
    @inlinable public mutating 
    func next() -> Diagnostics.Source.Element?
    {
        guard self.index != self.source.endIndex
        else 
        {
            return nil 
        }
        defer 
        {
            self.index = self.source.index(after: self.index)
        }
        return self.source[self.index]
    }
    /* private mutating 
    func group<Parser, T>(parser:Parser.Type, _ body:(inout Self) throws -> T) throws -> T
    {
        try self.group(rule: .parser(parser), body)
    }
    private mutating 
    func group<T>(file:StaticString, line:Int, _ body:(inout Self) throws -> T) throws -> T
    {
        try self.group(rule: .literal(file: file, line: line), body)
    } */
    @inlinable public mutating 
    func group<Rule, Construction>(_:Rule.Type, _ body:(inout Self) throws -> Construction) 
        throws -> Construction
    {
        let breadcrumb:Diagnostics.Breadcrumb = 
            self.diagnostics.push(index: self.index, for: Construction.self, by: Rule.self)
        do 
        {
            let construction:Construction = try body(&self)
            self.diagnostics.pop()
            return construction 
        }
        catch var error 
        {
            self.diagnostics.reset(index: &self.index, to: breadcrumb, because: &error)
            throw error
        }
    }
    
    @inlinable public mutating 
    func parse<Rule>(as _:Rule.Type) throws -> Rule.Construction 
        where   Rule:ParsingRule, Rule.Location == Diagnostics.Source.Index, Rule.Terminal == Diagnostics.Source.Element
    {
        try self.group(Rule.self){ try Rule.parse(&$0) }
    }
    
    @discardableResult 
    @inlinable public mutating 
    func parse<T0, T1>(as _:(T0, T1).Type) throws 
        -> (T0.Construction, T1.Construction) 
        where   T0:ParsingRule, T0.Location == Diagnostics.Source.Index, T0.Terminal == Diagnostics.Source.Element, 
                T1:ParsingRule, T1.Location == Diagnostics.Source.Index, T1.Terminal == Diagnostics.Source.Element 
    {
        try self.group((T0, T1).self)
        {
            let list:(T0.Construction, T1.Construction) 
            list.0 = try T0.parse(&$0)
            list.1 = try T1.parse(&$0)
            return list
        }
    }
    @discardableResult 
    @inlinable public mutating 
    func parse<T0, T1, T2>(as _:(T0, T1, T2).Type) throws 
        -> (T0.Construction, T1.Construction, T2.Construction) 
        where   T0:ParsingRule, T0.Location == Diagnostics.Source.Index, T0.Terminal == Diagnostics.Source.Element, 
                T1:ParsingRule, T1.Location == Diagnostics.Source.Index, T1.Terminal == Diagnostics.Source.Element,
                T2:ParsingRule, T2.Location == Diagnostics.Source.Index, T2.Terminal == Diagnostics.Source.Element 
    {
        try self.group((T0, T1, T2).self)
        {
            let list:(T0.Construction, T1.Construction, T2.Construction) 
            list.0 = try T0.parse(&$0)
            list.1 = try T1.parse(&$0)
            list.2 = try T2.parse(&$0)
            return list
        }
    }
    @discardableResult 
    @inlinable public mutating 
    func parse<T0, T1, T2, T3>(as _:(T0, T1, T2, T3).Type) throws 
        -> (T0.Construction, T1.Construction, T2.Construction, T3.Construction) 
        where   T0:ParsingRule, T0.Location == Diagnostics.Source.Index, T0.Terminal == Diagnostics.Source.Element, 
                T1:ParsingRule, T1.Location == Diagnostics.Source.Index, T1.Terminal == Diagnostics.Source.Element,
                T2:ParsingRule, T2.Location == Diagnostics.Source.Index, T2.Terminal == Diagnostics.Source.Element,
                T3:ParsingRule, T3.Location == Diagnostics.Source.Index, T3.Terminal == Diagnostics.Source.Element 
    {
        try self.group((T0, T1, T2, T3).self)
        {
            let list:(T0.Construction, T1.Construction, T2.Construction, T3.Construction) 
            list.0 = try T0.parse(&$0)
            list.1 = try T1.parse(&$0)
            list.2 = try T2.parse(&$0)
            list.3 = try T3.parse(&$0)
            return list
        }
    }
    @discardableResult 
    @inlinable public mutating 
    func parse<T0, T1, T2, T3, T4>(as _:(T0, T1, T2, T3, T4).Type) throws 
        -> (T0.Construction, T1.Construction, T2.Construction, T3.Construction, T4.Construction) 
        where   T0:ParsingRule, T0.Location == Diagnostics.Source.Index, T0.Terminal == Diagnostics.Source.Element, 
                T1:ParsingRule, T1.Location == Diagnostics.Source.Index, T1.Terminal == Diagnostics.Source.Element,
                T2:ParsingRule, T2.Location == Diagnostics.Source.Index, T2.Terminal == Diagnostics.Source.Element,
                T3:ParsingRule, T3.Location == Diagnostics.Source.Index, T3.Terminal == Diagnostics.Source.Element,
                T4:ParsingRule, T4.Location == Diagnostics.Source.Index, T4.Terminal == Diagnostics.Source.Element 
    {
        try self.group((T0, T1, T2, T3, T4).self)
        {
            let list:(T0.Construction, T1.Construction, T2.Construction, T3.Construction, T4.Construction) 
            list.0 = try T0.parse(&$0)
            list.1 = try T1.parse(&$0)
            list.2 = try T2.parse(&$0)
            list.3 = try T3.parse(&$0)
            list.4 = try T4.parse(&$0)
            return list
        }
    }
    @discardableResult 
    @inlinable public mutating 
    func parse<T0, T1, T2, T3, T4, T5>(as _:(T0, T1, T2, T3, T4, T5).Type) throws 
        -> (T0.Construction, T1.Construction, T2.Construction, T3.Construction, T4.Construction, T5.Construction) 
        where   T0:ParsingRule, T0.Location == Diagnostics.Source.Index, T0.Terminal == Diagnostics.Source.Element, 
                T1:ParsingRule, T1.Location == Diagnostics.Source.Index, T1.Terminal == Diagnostics.Source.Element,
                T2:ParsingRule, T2.Location == Diagnostics.Source.Index, T2.Terminal == Diagnostics.Source.Element,
                T3:ParsingRule, T3.Location == Diagnostics.Source.Index, T3.Terminal == Diagnostics.Source.Element,
                T4:ParsingRule, T4.Location == Diagnostics.Source.Index, T4.Terminal == Diagnostics.Source.Element,
                T5:ParsingRule, T5.Location == Diagnostics.Source.Index, T5.Terminal == Diagnostics.Source.Element 
    {
        try self.group((T0, T1, T2, T3, T4, T5).self)
        {
            let list:(T0.Construction, T1.Construction, T2.Construction, T3.Construction, T4.Construction, T5.Construction) 
            list.0 = try T0.parse(&$0)
            list.1 = try T1.parse(&$0)
            list.2 = try T2.parse(&$0)
            list.3 = try T3.parse(&$0)
            list.4 = try T4.parse(&$0)
            list.5 = try T5.parse(&$0)
            return list
        }
    }
    @discardableResult 
    @inlinable public mutating 
    func parse<T0, T1, T2, T3, T4, T5, T6>(as _:(T0, T1, T2, T3, T4, T5, T6).Type) throws 
        -> (T0.Construction, T1.Construction, T2.Construction, T3.Construction, T4.Construction, T5.Construction, T6.Construction) 
        where   T0:ParsingRule, T0.Location == Diagnostics.Source.Index, T0.Terminal == Diagnostics.Source.Element, 
                T1:ParsingRule, T1.Location == Diagnostics.Source.Index, T1.Terminal == Diagnostics.Source.Element,
                T2:ParsingRule, T2.Location == Diagnostics.Source.Index, T2.Terminal == Diagnostics.Source.Element,
                T3:ParsingRule, T3.Location == Diagnostics.Source.Index, T3.Terminal == Diagnostics.Source.Element,
                T4:ParsingRule, T4.Location == Diagnostics.Source.Index, T4.Terminal == Diagnostics.Source.Element,
                T5:ParsingRule, T5.Location == Diagnostics.Source.Index, T5.Terminal == Diagnostics.Source.Element,
                T6:ParsingRule, T6.Location == Diagnostics.Source.Index, T6.Terminal == Diagnostics.Source.Element 
    {
        try self.group((T0, T1, T2, T3, T4, T5, T6).self)
        {
            let list:(T0.Construction, T1.Construction, T2.Construction, T3.Construction, T4.Construction, T5.Construction, T6.Construction) 
            list.0 = try T0.parse(&$0)
            list.1 = try T1.parse(&$0)
            list.2 = try T2.parse(&$0)
            list.3 = try T3.parse(&$0)
            list.4 = try T4.parse(&$0)
            list.5 = try T5.parse(&$0)
            list.6 = try T6.parse(&$0)
            return list
        }
    }
}
extension ParsingInput
{
    // this overload will be preferred over the `throws` overload
    @inlinable public mutating 
    func parse<Rule>(as _:Rule?.Type) -> Rule.Construction? 
        where   Rule:ParsingRule, Rule.Location == Diagnostics.Source.Index, Rule.Terminal == Diagnostics.Source.Element
    {
        try? self.parse(as: Rule.self)
    }
    @inlinable public mutating 
    func parse<Rule>(as _:Rule.Type, in _:Void.Type) 
        where   Rule:ParsingRule, Rule.Location == Diagnostics.Source.Index, Rule.Terminal == Diagnostics.Source.Element, 
                Rule.Construction == Void 
    {
        while let _:Void = self.parse(as: Rule?.self)
        {
        }
    }
    @inlinable public mutating 
    func parse<Rule, Vector>(as _:Rule.Type, in _:Vector.Type) -> Vector
        where   Rule:ParsingRule, Rule.Location == Diagnostics.Source.Index, Rule.Terminal == Diagnostics.Source.Element, 
                Rule.Construction == Vector.Element, 
                Vector:RangeReplaceableCollection
    {
        var vector:Vector = .init()
        while let element:Rule.Construction = self.parse(as: Rule?.self)
        {
            vector.append(element)
        }
        return vector
    }
    @inlinable public mutating 
    func parse(prefix count:Int) throws -> Diagnostics.Source.SubSequence
    {
        guard let index:Diagnostics.Source.Index = 
            self.source.index(self.index, offsetBy: count, limitedBy: self.source.endIndex)
        else 
        {
            throw Grammar.Expected<Any, Diagnostics.Source.Element>.init(encountered: nil)
        }
        
        let prefix:Diagnostics.Source.SubSequence = self.source[self.index ..< index]
        self.index = index 
        return prefix
    }
}
// these extensions are mainly useful when defined as part of a tuple rule.
// otherwise, the overloads in the previous section of code should be preferred
extension Optional:ParsingRule where Wrapped:ParsingRule 
{
    public 
    typealias Location  = Wrapped.Location
    public 
    typealias Terminal  = Wrapped.Terminal 
    
    @inlinable public static 
    func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) -> Wrapped.Construction?
        where   Diagnostics:ParsingDiagnostics,
                Diagnostics.Source.Index == Location,
                Diagnostics.Source.Element == Terminal
    {
        // will choose non-throwing overload, so no infinite recursion will occur
        input.parse(as: Wrapped?.self)
    }
} 
extension Array:ParsingRule where Element:ParsingRule
{
    public
    typealias Location = Element.Location
    public
    typealias Terminal = Element.Terminal 
    
    @inlinable public static 
    func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) -> [Element.Construction]
        where   Diagnostics:ParsingDiagnostics,
                Diagnostics.Source.Index == Location,
                Diagnostics.Source.Element == Terminal
    {
        input.parse(as: Element.self, in: [Element.Construction].self)
    }
}

extension Grammar 
{
    @frozen public
    struct Expected<T, Terminal>:Error, CustomStringConvertible 
    {
        public
        let encountered:Terminal?
        public
        init(encountered:Terminal?)
        {
            self.encountered = encountered
        }
        public
        var description:String 
        {
            if let encountered:Terminal = self.encountered 
            {
                return "expected construction by rule '\(T.self)' (encountered '\(encountered)')"
            }
            else 
            {
                return "expected construction by rule '\(T.self)'"
            } 
        }
    }
    @frozen public
    struct Excluded<T, Exclusion>:Error, CustomStringConvertible 
    {
        public
        var description:String 
        {
            "value of type '\(T.self)' would also be a valid value of '\(Exclusion.self)'"
        }
    }
    public
    enum End<Location, Terminal>:ParsingRule 
    {
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws 
            where   Diagnostics:ParsingDiagnostics, 
                    Diagnostics.Source.Index == Location, 
                    Diagnostics.Source.Element == Terminal
        {
            if let terminal:Terminal = input.next() 
            {
                throw Expected<Never, Terminal>.init(encountered: terminal)
            }
        }
    }
    @inlinable public static 
    func parse<Source, Root>(diagnosing source:Source, as _:Root.Type) throws -> Root.Construction
        where   Source:Collection, Root:ParsingRule, 
                Root.Location == Source.Index, Root.Terminal == Source.Element
    {
        var input:ParsingInput<DefaultDiagnostics<Source>> = .init(source)
        let construction:Root.Construction = try input.parse(as: Root.self)
        try input.parse(as: End<Root.Location, Root.Terminal>.self)
        return construction
    }
    @inlinable public static 
    func parse<Source, Root>(_ source:Source, as _:Root.Type) throws -> Root.Construction
        where   Source:Collection, Root:ParsingRule, 
                Root.Location == Source.Index, Root.Terminal == Source.Element
    {
        var input:ParsingInput<NoDiagnostics<Source>> = .init(source)
        let construction:Root.Construction = try input.parse(as: Root.self)
        try input.parse(as: End<Root.Location, Root.Terminal>.self)
        return construction
    }
    @inlinable public static 
    func parse<Source, Rule, Vector>(_ source:Source, as _:Rule.Type, in _:Vector.Type) throws -> Vector
        where   Source:Collection, Rule:ParsingRule, 
                Rule.Location == Source.Index, Rule.Terminal == Source.Element, 
                Vector:RangeReplaceableCollection, Vector.Element == Rule.Construction
    {
        var input:ParsingInput<NoDiagnostics<Source>> = .init(source)
        let construction:Vector = input.parse(as: Rule.self, in: Vector.self)
        try input.parse(as: End<Rule.Location, Rule.Terminal>.self)
        return construction
    }
}
extension Grammar 
{
    public 
    typealias TerminalClass     = _GrammarTerminalClass
    public 
    typealias TerminalSequence  = _GrammarTerminalSequence
}
public
protocol _GrammarTerminalClass:ParsingRule
{
    static 
    func parse(terminal:Terminal) -> Construction?
}
extension Grammar.TerminalClass 
{
    @inlinable public static 
    func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws -> Construction
        where   Diagnostics:ParsingDiagnostics,
                Diagnostics.Source.Index == Location,
                Diagnostics.Source.Element == Terminal
    {
        guard let terminal:Terminal     = input.next()
        else 
        {
            throw Grammar.Expected<Self, Terminal>.init(encountered: nil)
        }
        guard let value:Construction    = Self.parse(terminal: terminal)
        else 
        {
            throw Grammar.Expected<Self, Terminal>.init(encountered: terminal)
        }
        return value 
    }
}
public
protocol _GrammarTerminalSequence:ParsingRule
    where Terminal:Equatable, Construction == Void 
{
    associatedtype Literal where Literal:Sequence, Literal.Element == Terminal 
    static 
    var literal:Literal
    {
        get 
    }
}
extension Grammar.TerminalSequence 
{
    @inlinable public static 
    func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws
        where   Diagnostics:ParsingDiagnostics, 
                Diagnostics.Source.Index == Location,
                Diagnostics.Source.Element == Terminal
    {
        for expected:Terminal in Self.literal
        {
            guard let element:Terminal = input.next()
            else 
            {
                throw Grammar.Expected<Self, Terminal>.init(encountered: nil)
            }
            guard element == expected 
            else 
            {
                throw Grammar.Expected<Self, Terminal>.init(encountered: element)
            }
        }
    }
}
public
protocol _GrammarDigitRule:Grammar.TerminalClass where Construction:BinaryInteger
{
    static 
    var radix:Construction 
    {
        get 
    }
}
extension Grammar 
{
    public 
    typealias DigitRule = _GrammarDigitRule
    @frozen public
    struct IntegerOverflowError<T>:Error, CustomStringConvertible 
    {
        public 
        init()
        {
        }
        public
        var description:String 
        {
            "parsed value overflows integer type '\(T.self)'"
        }
    }
    public
    enum UnsignedIntegerLiteral<Rule>:ParsingRule
        where Rule:DigitRule, Rule.Construction:FixedWidthInteger
    {
        public
        typealias Location = Rule.Location
        public
        typealias Terminal = Rule.Terminal
        
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws -> Rule.Construction
            where   Diagnostics:ParsingDiagnostics,
                    Diagnostics.Source.Index == Location,
                    Diagnostics.Source.Element == Terminal
        {
            var value:Rule.Construction            = try input.parse(as: Rule.self)
            while let remainder:Rule.Construction  =     input.parse(as: Rule?.self)
            {
                guard   case (let shifted, false) = value.multipliedReportingOverflow(by: Rule.radix), 
                        case (let refined, false) = shifted.addingReportingOverflow(remainder)
                else 
                {
                    throw IntegerOverflowError<Rule.Construction>.init()
                }
                value = refined
            }
            return value
        }
    }
}

extension Grammar 
{
    public 
    enum Encoding<Location, Terminal> 
    {
    }
    public 
    enum Digit<Location, Terminal, Construction> where Construction:BinaryInteger 
    {
    }
}
extension Grammar 
{
    public 
    enum Pad<Rule, Padding>:ParsingRule
        where   Rule:ParsingRule, Padding:ParsingRule, 
                Rule.Location == Padding.Location,
                Rule.Terminal == Padding.Terminal, 
                Padding.Construction == Void
    {
        public 
        typealias Terminal = Rule.Terminal
        public 
        typealias Location = Rule.Location
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws -> Rule.Construction
            where   Diagnostics:ParsingDiagnostics,
                    Diagnostics.Source.Index == Location,
                    Diagnostics.Source.Element == Terminal
        {
            input.parse(as: Padding.self, in: Void.self)
            let construction:Rule.Construction = try input.parse(as: Rule.self) 
            input.parse(as: Padding.self, in: Void.self)
            return construction
        }
    }
}
extension Grammar 
{
    public 
    enum Collect<Rule, Construction>:ParsingRule 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection
    {
        public 
        typealias Location = Rule.Location
        public 
        typealias Terminal = Rule.Terminal 
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) -> Construction
            where   Diagnostics:ParsingDiagnostics,
                    Diagnostics.Source.Index == Location,
                    Diagnostics.Source.Element == Terminal
        {
            input.parse(as: Rule.self, in: Construction.self)
        }
    }
    public 
    enum Reduce<Rule, Construction>:ParsingRule 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection
    {
        public 
        typealias Location = Rule.Location
        public 
        typealias Terminal = Rule.Terminal 
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws -> Construction
            where   Diagnostics:ParsingDiagnostics,
                    Diagnostics.Source.Index == Location,
                    Diagnostics.Source.Element == Terminal
        {
            var vector:Construction = .init()
                vector.append(try input.parse(as: Rule.self))
            while let next:Rule.Construction = input.parse(as: Rule?.self)
            {
                vector.append(next)
            }
            return vector
        }
    }
}

/* extension ParsingInput where Source.Element:Equatable 
{
    mutating 
    func parse(terminal:Source.Element, file:StaticString = #filePath, line:Int = #line) throws 
    {
        try self.parse(terminals: CollectionOfOne<Source.Element>.init(terminal), file: file, line: line)
    }
    mutating 
    func parse<S>(terminals:S, file:StaticString = #filePath, line:Int = #line) throws 
        where S:Sequence, S.Element == Source.Element
    {
        try self.group(file: file, line: line) 
        {
            for expected:S.Element in terminals
            {
                guard let element:Source.Element = $0.next()
                else 
                {
                    throw Grammar.ExpectedTerminal<S.Element>.init(expected, encountered: nil)
                }
                guard element == expected 
                else 
                {
                    throw Grammar.ExpectedTerminal<S.Element>.init(expected, encountered: element)
                }
            }
        }
    }
} */



// serialization // 


// extras //






/* protocol _GrammarBracketedExpression:ParsingRule 
    where Construction == Expression.Construction
{
    associatedtype Start        where      Start:ParsingRule,      Start.Terminal == Terminal,  Start.Construction == Void
    associatedtype Expression   where Expression:ParsingRule, Expression.Terminal == Terminal
    associatedtype End          where        End:ParsingRule,        End.Terminal == Terminal,    End.Construction == Void
    
    init(production:Construction) 
}
extension Grammar.BracketedExpression 
{
    init<C>(parsing input:inout ParsingInput<C, Diagnostics>) throws where C:Collection, C.Element == Terminal
    {
        try input.parse(as: Start.self)
        self.init(production: try input.parse(as: Expression.self))
        try input.parse(as: End.self)
    }
}
extension Grammar 
{
    typealias BracketedExpression = _GrammarBracketedExpression
} */


/* protocol _GrammarPower:ParsingRule
    where Construction:RangeReplaceableCollection
{
    associatedtype Rule 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element, 
                Rule.Terminal == Terminal, Rule.Location == Location
    static 
    var exponent:Int 
    {
        get 
    }
}
extension Grammar.Power 
{
    static 
    func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws -> Construction
        where   Diagnostics:ParsingDiagnostics,
                Diagnostics.Source.Index == Location,
                Diagnostics.Source.Element == Terminal
    {
        var vector:Construction = .init()
        for _:Int in 0 ..< Self.exponent
        {
            vector.append(try input.parse(as: Rule.self))
        }
        return vector 
    }
}
extension Grammar 
{
    typealias Power = _GrammarPower
    
    enum Reduce2<Rule, Construction>:Power 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection
    {
        typealias Location = Rule.Location
        typealias Terminal = Rule.Terminal 
        static 
        var exponent:Int 
        {
            2
        }
    }
    enum Reduce3<Rule, Construction>:Power 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection
    {
        typealias Location = Rule.Location
        typealias Terminal = Rule.Terminal 
        static 
        var exponent:Int 
        {
            3
        }
    }
    enum Reduce4<Rule, Construction>:Power 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection
    {
        typealias Location = Rule.Location
        typealias Terminal = Rule.Terminal 
        static 
        var exponent:Int 
        {
            4
        }
    }
    enum Reduce5<Rule, Construction>:Power 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection
    {
        typealias Location = Rule.Location
        typealias Terminal = Rule.Terminal 
        static 
        var exponent:Int 
        {
            5
        }
    }
    enum Reduce6<Rule, Construction>:Power 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection
    {
        typealias Location = Rule.Location
        typealias Terminal = Rule.Terminal 
        static 
        var exponent:Int 
        {
            6
        }
    }
    enum Reduce8<Rule, Construction>:Power 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection
    {
        typealias Location = Rule.Location
        typealias Terminal = Rule.Terminal 
        static 
        var exponent:Int 
        {
            8
        }
    }
    enum Reduce16<Rule, Construction>:Power 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection
    {
        typealias Location = Rule.Location
        typealias Terminal = Rule.Terminal 
        static 
        var exponent:Int 
        {
            16
        }
    }
} */

/* extension Grammar 
{
    struct BigEndian:RangeReplaceableCollection, RandomAccessCollection
    {
        private
        var digits:[UInt8] 
        
        var startIndex:Int 
        {
            self.digits.startIndex 
        }
        var endIndex:Int 
        {
            self.digits.endIndex
        }
        subscript(_ index:Int) -> Int 
        {
            Int.init(self.digits[index])
        }
        
        init() 
        {
            self.digits = []
        }
        
        mutating 
        func append(_ digit:Int)
        {
            self.digits.append(UInt8.init(digit))
        }
        mutating 
        func replaceSubrange<C>(_ range:Range<Int>, with new:C) where C:Collection, C.Element == Int
        {
            self.digits.replaceSubrange(range, with: new.map(UInt8.init(_:)))
        }
        
        func `as`<T>(_ type:T.Type, radix:T) throws -> T where T:FixedWidthInteger
        {
            guard var value:T = self.digits.first.map(T.init(_:))
            else 
            {
                return T.zero 
            }
            for digit:UInt8 in self.digits.dropFirst()
            {
                guard   case (let product, false) = value.multipliedReportingOverflow(by: radix), 
                        case (let next,    false) = product.addingReportingOverflow(T.init(digit))
                else 
                {
                    throw Grammar.IntegerOverflowError<T>.init()
                }
                value = next 
            }
            return value
        }
        
        func match<T>(exactly value:T, radix:T) -> Bool where T:FixedWidthInteger 
        {
            var digits:ReversedCollection<[UInt8]>.Iterator = self.digits.reversed().makeIterator()
            var value:T = value 
            repeat 
            {
                let next:(quotient:T, remainder:T)  = value.quotientAndRemainder(dividingBy: radix)
                let remainder:UInt8                 = .init(next.remainder)
                value                               =       next.quotient 
                
                guard   let digit:UInt8 =  digits.next(), 
                            digit       == remainder 
                else 
                {
                    return false 
                }
            }
            while value     != 0 
            guard case .none = digits.next()
            else 
            {
                return false 
            }
            return true 
        }
    }
}
extension Grammar.BigEndian:CustomStringConvertible 
{
    var description:String 
    {
        var string:String = ""
        for digit:UInt8 in self.digits
        {
            // dont use the code from `Character.HexDigit.Anycase`, because 
            // radices may be greater than 16
            let character:Character
            if digit < 10 
            {
                character = .init(Unicode.Scalar.init(0x30 + digit))
            }
            else 
            {
                // lowercase 
                character = .init(Unicode.Scalar.init(0x57 + digit))
            }
            string.append(character)
        }
        return string 
    }
} */
