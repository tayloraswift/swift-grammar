/// A structured parsing rule.
public 
protocol ParsingRule<Terminal> 
{
    /// The index type of the ``ParsingInput.source`` this rule expects.
    /// 
    /// Parsing rules must be associated with a source location type because 
    /// some applications may wish to store these indices in the returned 
    /// ``Construction``s. If the source location type were not fixed, then 
    /// different calls to ``parse(_:)`` could potentially return constructions
    /// of varying types, which would require additional abstraction, which would 
    /// be inefficient.
    /// 
    /// >   Tip: 
    ///     Implementations can satisfy this requirement with generics, allowing 
    ///     parsing rules to be reused for different input types. 
    associatedtype Location
    /// The element type of the ``ParsingInput.source`` this rule expects.
    associatedtype Terminal 
    /// The type of the constructions produced by a successful application of this 
    /// parsing rule.
    /// 
    /// Implementations should not report failure through an ``Optional`` 
    /// construction type. Instead, implementations should [`throw`]() an ``Error``, 
    /// which allows the library to perform appropriate cleanup and backtracking.
    associatedtype Construction
    
    /// Attempts to parse an instance of ``Construction`` from the given 
    /// parsing input.
    ///
    /// The implementation is not required to clean up the state of the `input`
    /// upon throwing an error; this is handled by the library.
    /// 
    /// Implementations *should* interact with the given ``ParsingInput`` by 
    /// calling its methods and subscripts. Don’t overwrite the [`inout`]() binding or its 
    /// mutable stored properties (``ParsingInput/.index`` and ``ParsingInput/.diagnostics``)
    /// unless you really know what you’re doing.
    /// 
    /// >   Tip: 
    ///     Mutating `input` does *not* invalidate its indices. You can always 
    ///     store an ``ParsingInput/.index`` and dereference it later, as long 
    ///     as you do not overwrite the [`inout`]() binding elsewhere.
    static 
    func parse<Source>(
        _ input:inout ParsingInput<some ParsingDiagnostics<Source>>) throws -> Construction
        where Source:Collection<Terminal>, Source.Index == Location
}

extension ParsingRule 
{
    /// Attempts to parse the given input completely, emitting diagnostics 
    /// if parsing failed.
    ///
    /// 
    /// >   Throws: 
    ///     A ``Pattern.UnexpectedValueError`` if there remained any 
    ///     unparsed input after applying this rule to its furthest extent.
    @inlinable public static 
    func parse<Source>(diagnosing source:Source) throws -> Construction
        where Source:Collection<Terminal>, Source.Index == Location
    {
        var input:ParsingInput<DefaultDiagnostics<Source>> = .init(source)
        let construction:Construction = try input.parse(as: Self.self)
        try input.parse(as: Pattern.End<Location, Terminal>.self)
        return construction
    }
    /// Attempts to parse the given input completely.
    /// 
    /// This method is *not* a default implementation for 
    /// ``parse(_:)?overload=s7Grammar11ParsingRuleP5parsey12ConstructionQzAA0B5InputVyqd__GzKAA0B11DiagnosticsRd__6Source_5IndexQYd__8LocationRtzAK_7ElementQYd__8TerminalRtzlFZ``; 
    /// that is a SymbolGraphGen classifier bug.
    /// 
    /// To parse with diagnostics, use ``parse(diagnosing:)``.
    /// >   Throws: 
    ///     A ``Pattern.UnexpectedValueError`` if there remained any 
    ///     unparsed input after applying this rule to its furthest extent.
    @inlinable public static 
    func parse<Source>(_ source:Source) throws -> Construction
        where Source:Collection<Terminal>, Source.Index == Location
    {
        var input:ParsingInput<NoDiagnostics<Source>> = .init(source)
        let construction:Construction = try input.parse(as: Self.self)
        try input.parse(as: Pattern.End<Location, Terminal>.self)
        return construction
    }
    /// Attempts to parse the given input completely by applying this rule repeatedly.
    /// 
    /// This function does not parse with diagnostics.
    /// >   Throws: 
    ///     A ``Pattern.UnexpectedValueError`` if there remained any 
    ///     unparsed input after applying this rule to its furthest extent.
    @inlinable public static 
    func parse<Source, Vector>(_ source:Source, into _:Vector.Type = Vector.self) 
        throws -> Vector
        where   Source:Collection<Terminal>, Source.Index == Location,
                Vector:RangeReplaceableCollection<Construction>
    {
        var input:ParsingInput<NoDiagnostics<Source>> = .init(source)
        let construction:Vector = input.parse(as: Self.self, in: Vector.self)
        try input.parse(as: Pattern.End<Location, Terminal>.self)
        return construction
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
    func parse<Source>(
        _ input:inout ParsingInput<some ParsingDiagnostics<Source>>) -> Wrapped.Construction?
        where Source:Collection<Terminal>, Source.Index == Location
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
    func parse<Source>(
        _ input:inout ParsingInput<some ParsingDiagnostics<Source>>) -> [Element.Construction]
        where Source:Collection<Terminal>, Source.Index == Location
    {
        input.parse(as: Element.self, in: [Element.Construction].self)
    }
}
