@available(*, deprecated, renamed: "NoDiagnostics")
public 
typealias _NoDiagnostics = NoDiagnostics
@available(*, deprecated, renamed: "DefaultDiagnostics")
public 
typealias _DefaultDiagnostics = DefaultDiagnostics

/// A namespace for structured parsing utilities.
@available(*, deprecated)
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

    @available(*, deprecated, renamed: "ParsingRule.parse(diagnosing:)")
    @inlinable public static 
    func parse<Source, Root>(diagnosing source:Source, as _:Root.Type) throws -> Root.Construction
        where   Source:Collection, Root:ParsingRule<Source.Element>, 
                Root.Location == Source.Index
    {
        try Root.parse(diagnosing: source)
    }

    @available(*, deprecated, renamed: "ParsingRule.parse(_:)")
    @inlinable public static 
    func parse<Source, Root>(_ source:Source, as _:Root.Type) throws -> Root.Construction
        where   Source:Collection, Root:ParsingRule<Source.Element>, 
                Root.Location == Source.Index
    {
        try Root.parse(source)
    }
    @available(*, deprecated, renamed: "ParsingRule.parse(_:into:)")
    @inlinable public static 
    func parse<Source, Rule, Vector>(_ source:Source, as _:Rule.Type, in _:Vector.Type) throws -> Vector
        where   Source:Collection,
                Rule:ParsingRule<Source.Element>, Rule.Location == Source.Index, 
                Vector:RangeReplaceableCollection<Rule.Construction>
    {
        try Rule.parse(source, into: Vector.self)
    }
    
    @available(*, deprecated, renamed: "LiteralRule")
    public 
    typealias TerminalSequence  = LiteralRule
    
    @available(*, deprecated, renamed: "TerminalRule")
    public 
    typealias TerminalClass     = TerminalRule

    /// ``Grammar//NoDiagnostics`` was moved to the top-level 
    /// namespace of this module.
    @available(*, deprecated, renamed: "NoDiagnostics")
    public 
    typealias NoDiagnostics = _NoDiagnostics 

    /// ``Grammar//DefaultDiagnostics`` was moved to the top-level 
    /// namespace of this module.
    @available(*, deprecated, renamed: "DefaultDiagnostics")
    public 
    typealias DefaultDiagnostics = _DefaultDiagnostics

    @available(*, deprecated, renamed: "Pattern.End")
    public
    typealias End<Location, Terminal> = Pattern.End<Location, Terminal>

    @available(*, deprecated, renamed: "Pattern.Discard")
    public 
    typealias Discard<Rule> = Pattern.Discard<Rule>
        where   Rule:ParsingRule, Rule.Construction == Void

    @available(*, deprecated, renamed: "Pattern.Collect")
    public 
    typealias Collect<Rule, Construction> = Pattern.Collect<Rule, Construction>
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection

    @available(*, deprecated, renamed: "Pattern.Reduce")
    public 
    typealias Reduce<Rule, Construction> = Pattern.Reduce<Rule, Construction>
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection

    @available(*, deprecated, renamed: "Pattern.Join")
    public 
    typealias Join<Rule, Separator, Construction> = Pattern.Join<Rule, Separator, Construction>
        where   Rule:ParsingRule, Separator:ParsingRule,
                Rule.Location == Separator.Location, 
                Rule.Terminal == Separator.Terminal, 
                Separator.Construction == Void, 
                Rule.Construction == Construction.Element, 
                Construction:RangeReplaceableCollection

    @available(*, deprecated, renamed: "Pattern.Pad")
    public 
    typealias Pad<Rule, Padding> = Pattern.Pad<Rule, Padding>
        where   Rule:ParsingRule, Padding:ParsingRule, 
                Rule.Location == Padding.Location,
                Rule.Terminal == Padding.Terminal, 
                Padding.Construction == Void

    @available(*, deprecated, renamed: "UnicodeDigit.Natural")
    public 
    typealias   NaturalDecimalDigit<Location, Terminal, Construction> = 
                UnicodeDigit<Location, Terminal, Construction>.Natural
        where Terminal:BinaryInteger, Construction:BinaryInteger
    @available(*, deprecated, renamed: "UnicodeDigit.Decimal")
    public 
    typealias   DecimalDigit<Location, Terminal, Construction> = 
                UnicodeDigit<Location, Terminal, Construction>.Decimal
        where Terminal:BinaryInteger, Construction:BinaryInteger
    @available(*, deprecated, renamed: "UnicodeDigit.Hex")
    public 
    typealias   HexDigit<Location, Terminal, Construction> = 
                UnicodeDigit<Location, Terminal, Construction>.Hex
        where Terminal:BinaryInteger, Construction:BinaryInteger
    
    @available(*, deprecated, renamed: "UnicodeDigit.NaturalScalar")
    public 
    typealias   NaturalDecimalDigitScalar<Location, Construction> = 
                UnicodeDigit<Location, Unicode.Scalar, Construction>.NaturalScalar
        where Construction:BinaryInteger
    @available(*, deprecated, renamed: "UnicodeDigit.DecimalScalar")
    public 
    typealias   DecimalDigitScalar<Location, Construction> = 
                UnicodeDigit<Location, Unicode.Scalar, Construction>.DecimalScalar
        where Construction:BinaryInteger
    @available(*, deprecated, renamed: "UnicodeDigit.HexScalar")
    public 
    typealias   HexDigitScalar<Location, Construction> = 
                UnicodeDigit<Location, Unicode.Scalar, Construction>.HexScalar
        where Construction:BinaryInteger

    @available(*, deprecated, renamed: "Pattern.IntegerOverflowError")
    public
    typealias IntegerOverflowError<T> = Pattern.IntegerOverflowError<T> where T:FixedWidthInteger
    
    @available(*, deprecated, renamed: "Pattern.UnsignedInteger")
    public
    typealias UnsignedIntegerLiteral<Digit> = Pattern.UnsignedInteger<Digit>
        where Digit:DigitRule, Digit.Construction:FixedWidthInteger
    
    @available(*, deprecated, renamed: "Pattern.UnsignedNormalizedInteger")
    public
    typealias UnsignedNormalizedIntegerLiteral<First, Next> = 
        Pattern.UnsignedNormalizedInteger<First, Next>
        where   First:ParsingRule, Next:DigitRule, Next.Construction:FixedWidthInteger, 
                First.Construction == Next.Construction, 
                First.Location == Next.Location, 
                First.Terminal == Next.Terminal
}
