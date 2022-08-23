/// A namespace for structured parsing utilities.
public 
enum Grammar 
{
    // note: this only works on swift >= 5.7
    /// A shortcut for expressing the type constraints on ``ParsingRule.parse(_:)``.
    /// 
    /// To use this compile-time abstraction, fill in its generic parameters and 
    /// declare that it must conform to [`Any`]().
    /// 
    /// For example, the following:
    /** 
    ```swift 
    static 
    func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) 
        throws -> Void?
        where Grammar.Parsable<String.Index, UInt8, Diagnostics>:Any
    {
        // ...
    }
    ```
    */
    /// is equivalent to:
    /** 
    ```swift 
    static 
    func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) 
        throws -> Void?
        where   Diagnostics:ParsingDiagnostics, 
                Diagnostics.Source.Index == String.Index,
                Diagnostics.Source.Element == UInt8
    {
        // ...
    }
    ```
    */
    public 
    typealias Parsable<Location, Terminal, Diagnostics> = Never 
        where   Diagnostics:ParsingDiagnostics, 
                Diagnostics.Source.Index == Location, 
                Diagnostics.Source.Element == Terminal

    /// A generic context for unicode definitions.
    @available(*, deprecated, renamed: "UnicodeEncoding")
    public 
    typealias Encoding = UnicodeEncoding
    
    @frozen public
    struct Expected<T>:Error, CustomStringConvertible 
    {
        @inlinable public
        init()
        {
        }
        public
        var description:String 
        {
            "expected construction by rule '\(T.self)'"
        }
    }
    @frozen public
    struct ExpectedRegion<Base, Exclusion>:Error, CustomStringConvertible 
    {
        @inlinable public
        init()
        {
        }
        public
        var description:String 
        {
            "value of type '\(Base.self)' would also be a valid value of '\(Exclusion.self)'"
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
    @available(*, deprecated, renamed: "LiteralRule")
    public 
    typealias TerminalSequence  = LiteralRule
    
    @available(*, deprecated, renamed: "TerminalRule")
    public 
    typealias TerminalClass     = TerminalRule
}
