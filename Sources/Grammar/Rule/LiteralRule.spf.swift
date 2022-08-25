
#if swift(>=5.7)
/// A parsing rule that matches terminals against a constant ``Sequence``.
public
protocol LiteralRule<Terminal>:ParsingRule
    where Terminal:Equatable, Construction == Void 
{
    associatedtype Literal where Literal:Sequence, Literal.Element == Terminal 
    static 
    var literal:Literal
    {
        get 
    }
}
#else 
/// A parsing rule that matches terminals against a constant ``Sequence``.
public
protocol LiteralRule:ParsingRule
    where Terminal:Equatable, Construction == Void 
{
    associatedtype Literal where Literal:Sequence, Literal.Element == Terminal 
    static 
    var literal:Literal
    {
        get 
    }
}
#endif 
extension LiteralRule
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
                throw Pattern.ApplicationError<Self>.init()
            }
            guard element == expected 
            else 
            {
                throw Pattern.ApplicationError<Self>.init()
            }
        }
    }
}
