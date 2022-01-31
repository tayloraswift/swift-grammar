// parsing // 
protocol ParsingDiagnostics 
{
}
protocol ParsingRule 
{
    associatedtype Location
    associatedtype Terminal 
    associatedtype Construction
    
    static 
    func parse<Source, Diagnostics>(_ input:inout ParsingInput<Source, Diagnostics>) 
        throws -> Construction
        where   Diagnostics:ParsingDiagnostics, 
                Source:Collection, Source.Index == Location, Source.Element == Terminal
}
struct ParsingError<Source>:TraceableError, CustomStringConvertible where Source:Collection
{
    static 
    var namespace:String 
    {
        "parsing error"
    }
    let problem:Error, 
        source:Source, 
        index:Source.Index,
        trace:[(index:Source.Index, rule:Any.Type, type:Any.Type)]
    
    init(at index:Source.Index, in source:Source, because problem:Error, 
        trace:[(index:Source.Index, rule:Any.Type, type:Any.Type)])
    {
        self.problem    = problem
        self.source     = source 
        self.index      = index 
        self.trace      = trace
    }

    var context:[String] 
    {
        [ "while parsing input sequence '\(self.source)'" ]
        +
        trace.map 
        {
            if $0.type is Void.Type
            {
                return "while parsing constructionless rule '\($0.rule)'"
            }
            else 
            {
                return "while parsing value of type '\($0.type)' by rule '\($0.rule)'"
            }
        }
    } 
    var next:Error? 
    {
        self.problem 
    }
}

enum Grammar 
{
    struct DefaultDiagnostics:ParsingDiagnostics 
    {
    }
}
struct ParsingInput<Source, Diagnostics> where Source:Collection, Diagnostics:ParsingDiagnostics
{
    private 
    let source:Source
    private(set)
    var index:Source.Index 
    
    private 
    var stack:[(index:Source.Index, rule:Any.Type, type:Any.Type)], 
        frontier:ParsingError<Source>?
    
    init(_ source:Source)
    {
        self.source     = source 
        self.index      = source.startIndex 
        self.stack      = []
        self.frontier   = nil 
    }
    
    subscript(_ index:Source.Index) -> Source.Element 
    {
        self.source[index]
    }
    subscript<Indices>(_ range:Indices) -> Source.SubSequence 
        where Indices:RangeExpression, Indices.Bound == Source.Index 
    {
        self.source[range.relative(to: self.source)]
    }
    
    fileprivate mutating 
    func next() -> Source.Element?
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
    private mutating 
    func group<Rule, Construction>(_:Rule.Type, _ body:(inout Self) throws -> Construction) 
        throws -> Construction
    {
        let _index:Source.Index = self.index 
        do 
        {
            return try body(&self)
        }
        catch let error 
        {
            self.index = _index 
            throw error
        }
        /* 
        self.stack.append((self.index, Rule.self, Construction.self))
        
        do 
        {
            let construction:Construction = try body(&self)
            self.stack.removeLast()
            return construction
        }
        catch let diagnostic as ParsingError<Source> 
        {
            self.index = self.stack.removeLast().index 
            throw diagnostic
        }
        catch let error 
        {
            let diagnostic:ParsingError<Source>
            if  let frontier:ParsingError<Source>   = self.frontier, 
                    self.index < frontier.index
            {
                // we did not make it as far as the previous most-successful parse 
                diagnostic      = frontier 
            }
            else 
            {
                diagnostic      = .init(at: self.index, in: self.source, because: error, trace: self.stack) 
                self.frontier   = diagnostic 
            }
            self.index = self.stack.removeLast().index 
            throw diagnostic
        } */
    }
    
    mutating 
    func parse<Rule>(as _:Rule.Type) throws -> Rule.Construction 
        where   Rule:ParsingRule, Rule.Location == Source.Index, Rule.Terminal == Source.Element
    {
        try self.group(Rule.self){ try Rule.parse(&$0) }
    }
    
    @discardableResult 
    mutating 
    func parse<T0, T1>(as _:(T0, T1).Type) throws 
        -> (T0.Construction, T1.Construction) 
        where   T0:ParsingRule, T0.Location == Source.Index, T0.Terminal == Source.Element, 
                T1:ParsingRule, T1.Location == Source.Index, T1.Terminal == Source.Element 
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
    mutating 
    func parse<T0, T1, T2>(as _:(T0, T1, T2).Type) throws 
        -> (T0.Construction, T1.Construction, T2.Construction) 
        where   T0:ParsingRule, T0.Location == Source.Index, T0.Terminal == Source.Element, 
                T1:ParsingRule, T1.Location == Source.Index, T1.Terminal == Source.Element,
                T2:ParsingRule, T2.Location == Source.Index, T2.Terminal == Source.Element 
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
    mutating 
    func parse<T0, T1, T2, T3>(as _:(T0, T1, T2, T3).Type) throws 
        -> (T0.Construction, T1.Construction, T2.Construction, T3.Construction) 
        where   T0:ParsingRule, T0.Location == Source.Index, T0.Terminal == Source.Element, 
                T1:ParsingRule, T1.Location == Source.Index, T1.Terminal == Source.Element,
                T2:ParsingRule, T2.Location == Source.Index, T2.Terminal == Source.Element,
                T3:ParsingRule, T3.Location == Source.Index, T3.Terminal == Source.Element 
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
    mutating 
    func parse<T0, T1, T2, T3, T4>(as _:(T0, T1, T2, T3, T4).Type) throws 
        -> (T0.Construction, T1.Construction, T2.Construction, T3.Construction, T4.Construction) 
        where   T0:ParsingRule, T0.Location == Source.Index, T0.Terminal == Source.Element, 
                T1:ParsingRule, T1.Location == Source.Index, T1.Terminal == Source.Element,
                T2:ParsingRule, T2.Location == Source.Index, T2.Terminal == Source.Element,
                T3:ParsingRule, T3.Location == Source.Index, T3.Terminal == Source.Element,
                T4:ParsingRule, T4.Location == Source.Index, T4.Terminal == Source.Element 
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
    mutating 
    func parse<T0, T1, T2, T3, T4, T5>(as _:(T0, T1, T2, T3, T4, T5).Type) throws 
        -> (T0.Construction, T1.Construction, T2.Construction, T3.Construction, T4.Construction, T5.Construction) 
        where   T0:ParsingRule, T0.Location == Source.Index, T0.Terminal == Source.Element, 
                T1:ParsingRule, T1.Location == Source.Index, T1.Terminal == Source.Element,
                T2:ParsingRule, T2.Location == Source.Index, T2.Terminal == Source.Element,
                T3:ParsingRule, T3.Location == Source.Index, T3.Terminal == Source.Element,
                T4:ParsingRule, T4.Location == Source.Index, T4.Terminal == Source.Element,
                T5:ParsingRule, T5.Location == Source.Index, T5.Terminal == Source.Element 
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
    mutating 
    func parse<T0, T1, T2, T3, T4, T5, T6>(as _:(T0, T1, T2, T3, T4, T5, T6).Type) throws 
        -> (T0.Construction, T1.Construction, T2.Construction, T3.Construction, T4.Construction, T5.Construction, T6.Construction) 
        where   T0:ParsingRule, T0.Location == Source.Index, T0.Terminal == Source.Element, 
                T1:ParsingRule, T1.Location == Source.Index, T1.Terminal == Source.Element,
                T2:ParsingRule, T2.Location == Source.Index, T2.Terminal == Source.Element,
                T3:ParsingRule, T3.Location == Source.Index, T3.Terminal == Source.Element,
                T4:ParsingRule, T4.Location == Source.Index, T4.Terminal == Source.Element,
                T5:ParsingRule, T5.Location == Source.Index, T5.Terminal == Source.Element,
                T6:ParsingRule, T6.Location == Source.Index, T6.Terminal == Source.Element 
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
    mutating 
    func parse<Rule>(as _:Rule?.Type) -> Rule.Construction? 
        where   Rule:ParsingRule, Rule.Location == Source.Index, Rule.Terminal == Source.Element
    {
        try? self.parse(as: Rule.self)
    }
    mutating 
    func parse<Rule>(as _:Rule.Type, in _:Void.Type) 
        where   Rule:ParsingRule, Rule.Location == Source.Index, Rule.Terminal == Source.Element, 
                Rule.Construction == Void 
    {
        while let _:Void = self.parse(as: Rule?.self)
        {
        }
    }
    mutating 
    func parse<Rule, Vector>(as _:Rule.Type, in _:Vector.Type) -> Vector
        where   Rule:ParsingRule, Rule.Location == Source.Index, Rule.Terminal == Source.Element, 
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
    
    mutating 
    func parse(prefix count:Int) throws -> Source.SubSequence
    {
        guard let index:Source.Index = 
            self.source.index(self.index, offsetBy: count, limitedBy: self.source.endIndex)
        else 
        {
            throw Grammar.Expected<Any, Source.Element>.init(encountered: nil)
        }
        
        let prefix:Source.SubSequence = self.source[self.index ..< index]
        self.index = index 
        return prefix
    }
}
// these extensions are mainly useful when defined as part of a tuple rule.
// otherwise, the overloads in the previous section of code should be preferred
extension Optional:ParsingRule where Wrapped:ParsingRule 
{
    typealias Location  = Wrapped.Location
    typealias Terminal  = Wrapped.Terminal 
    
    static 
    func parse<Source, Diagnostics>(_ input:inout ParsingInput<Source, Diagnostics>) -> Wrapped.Construction?
        where   Diagnostics:ParsingDiagnostics,
                Source:Collection, Source.Index == Location, Source.Element == Terminal
    {
        // will choose non-throwing overload, so no infinite recursion will occur
        input.parse(as: Wrapped?.self)
    }
} 
extension Array:ParsingRule where Element:ParsingRule
{
    typealias Location = Element.Location
    typealias Terminal = Element.Terminal 
    
    static 
    func parse<Source, Diagnostics>(_ input:inout ParsingInput<Source, Diagnostics>) -> [Element.Construction]
        where   Diagnostics:ParsingDiagnostics,
                Source:Collection, Source.Index == Location, Source.Element == Terminal
    {
        input.parse(as: Element.self, in: [Element.Construction].self)
    }
}

extension Grammar 
{
    struct Expected<T, Terminal>:Error, CustomStringConvertible 
    {
        let encountered:Terminal?
        
        init(encountered:Terminal?)
        {
            self.encountered = encountered
        }
        var description:String 
        {
            if let encountered:Terminal = self.encountered 
            {
                return "expected construction by rule '\(T.self) (encountered '\(encountered)')"
            }
            else 
            {
                return "expected construction by rule '\(T.self)"
            } 
        }
    }
    struct Excluded<T, Exclusion>:Error, CustomStringConvertible 
    {
        var description:String 
        {
            "value of type '\(T.self)' would also be a valid value of '\(Exclusion.self)'"
        }
    }
    
    enum End<Location, Terminal>:ParsingRule 
    {
        static 
        func parse<Source, Diagnostics>(_ input:inout ParsingInput<Source, Diagnostics>) throws 
            where   Diagnostics:ParsingDiagnostics, 
                    Source:Collection, Source.Index == Location, Source.Element == Terminal
        {
            if let terminal:Terminal = input.next() 
            {
                throw Expected<Never, Terminal>.init(encountered: terminal)
            }
        }
    }
    static 
    func parse<Source, Root>(_ source:Source, as _:Root.Type) throws -> Root.Construction
        where   Source:Collection, Root:ParsingRule, 
                Root.Location == Source.Index, Root.Terminal == Source.Element
    {
        var input:ParsingInput<Source, Grammar.DefaultDiagnostics> = .init(source)
        let construction:Root.Construction          = try input.parse(as: Root.self)
        try input.parse(as: End<Root.Location, Root.Terminal>.self)
        return construction
    }
    static 
    func parse<Source, Rule, Vector>(_ source:Source, as _:Rule.Type, in _:Vector.Type) throws -> Vector
        where   Source:Collection, Rule:ParsingRule, 
                Rule.Location == Source.Index, Rule.Terminal == Source.Element, 
                Vector:RangeReplaceableCollection, Vector.Element == Rule.Construction
    {
        var input:ParsingInput<Source, Grammar.DefaultDiagnostics> = .init(source)
        let construction:Vector                     = input.parse(as: Rule.self, in: Vector.self)
        try input.parse(as: End<Rule.Location, Rule.Terminal>.self)
        return construction
    }
}
extension Grammar 
{
    typealias TerminalClass     = _GrammarTerminalClass
    typealias TerminalSequence  = _GrammarTerminalSequence
}
protocol _GrammarTerminalClass:ParsingRule
{
    static 
    func parse(terminal:Terminal) -> Construction?
}
extension Grammar.TerminalClass 
{
    static 
    func parse<Source, Diagnostics>(_ input:inout ParsingInput<Source, Diagnostics>) throws -> Construction
        where   Diagnostics:ParsingDiagnostics,
                Source:Collection, Source.Index == Location, Source.Element == Terminal
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
    static 
    func parse<Source, Diagnostics>(_ input:inout ParsingInput<Source, Diagnostics>) throws
        where   Diagnostics:ParsingDiagnostics,
                Source:Collection, Source.Element == Terminal
    {
        for expected:Terminal in Self.literal
        {
            guard let element:Source.Element = input.next()
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
    typealias DigitRule = _GrammarDigitRule
    
    struct IntegerOverflowError<T>:Error, CustomStringConvertible 
    {
        var description:String 
        {
            "parsed value overflows interger type '\(T.self)'"
        }
    }
    
    enum UnsignedIntegerLiteral<Rule>:ParsingRule
        where Rule:DigitRule, Rule.Construction:FixedWidthInteger
    {
        typealias Location = Rule.Location
        typealias Terminal = Rule.Terminal
        
        static 
        func parse<Source, Diagnostics>(_ input:inout ParsingInput<Source, Diagnostics>) throws -> Rule.Construction
            where   Diagnostics:ParsingDiagnostics,
                    Source:Collection, Source.Index == Location, Source.Element == Terminal
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
    enum Encoding<Location, Terminal> 
    {
    }
    enum Digit<Location, Terminal, Construction> where Construction:BinaryInteger 
    {
    }
}
extension Grammar 
{
    enum Pad<Rule, Padding>:ParsingRule
        where   Rule:ParsingRule, Padding:ParsingRule, 
                Rule.Location == Padding.Location,
                Rule.Terminal == Padding.Terminal, 
                Padding.Construction == Void
    {
        typealias Terminal = Rule.Terminal
        typealias Location = Rule.Location
        static 
        func parse<Source, Diagnostics>(_ input:inout ParsingInput<Source, Diagnostics>) throws -> Rule.Construction
            where   Diagnostics:ParsingDiagnostics,
                    Source:Collection, Source.Index == Location, Source.Element == Terminal
        {
            input.parse(as: Padding.self, in: Void.self)
            let construction:Rule.Construction = try input.parse(as: Rule.self) 
            input.parse(as: Padding.self, in: Void.self)
            return construction
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

extension Grammar 
{
    enum Collect<Rule, Construction>:ParsingRule 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection
    {
        typealias Location = Rule.Location
        typealias Terminal = Rule.Terminal 
        
        static 
        func parse<Source, Diagnostics>(_ input:inout ParsingInput<Source, Diagnostics>) -> Construction
            where   Diagnostics:ParsingDiagnostics,
                    Source:Collection, Source.Index == Location, Source.Element == Terminal
        {
            input.parse(as: Rule.self, in: Construction.self)
        }
    }
    enum Reduce<Rule, Construction>:ParsingRule 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection
    {
        typealias Location = Rule.Location
        typealias Terminal = Rule.Terminal 
        
        static 
        func parse<Source, Diagnostics>(_ input:inout ParsingInput<Source, Diagnostics>) throws -> Construction
            where   Diagnostics:ParsingDiagnostics,
                    Source:Collection, Source.Index == Location, Source.Element == Terminal
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
    func parse<Source, Diagnostics>(_ input:inout ParsingInput<Source, Diagnostics>) throws -> Construction
        where   Diagnostics:ParsingDiagnostics,
                Source:Collection, Source.Index == Location, Source.Element == Terminal
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
