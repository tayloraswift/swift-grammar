/// A mutable interface for interacting with source input in a safe and 
/// structured manner.
/// 
/// The [`Diagnostics`]() generic parameter provides a zero-cost abstraction 
/// for configuring the debugging information emitted if parsing fails.
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
    @inlinable public 
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
    /// Applies a parsing rule, or a group of parsing rules, appropriately 
    /// handling cleanup, backtracking, and diagnostic reporting if the parsing 
    /// rule throws an error.
    /// 
    /// This API is used by other library methods that are emitted into the 
    /// client. Although it is safe to use, library users should rarely need 
    /// to call it directly.
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
            throw Grammar.Expected<Any>.init()
        }
        
        let prefix:Diagnostics.Source.SubSequence = self.source[self.index ..< index]
        self.index = index 
        return prefix
    }
}
