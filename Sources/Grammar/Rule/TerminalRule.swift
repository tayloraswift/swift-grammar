
/// A parsing rule that is applied to a single terminal at a time.
public
protocol TerminalRule<Terminal, Construction>:ParsingRule
{
    static 
    func parse(terminal:Terminal) -> Construction?
}

extension TerminalRule
{
    @inlinable public static 
    func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws -> Construction
    where   Diagnostics:ParsingDiagnostics, 
            Diagnostics.Source.Index == Location, 
            Diagnostics.Source.Element == Terminal
    {
        guard let terminal:Terminal = input.next()
        else
        {
            throw Pattern.UnexpectedEndOfInputError.init()
        }
        guard let value:Construction = Self.parse(terminal: terminal)
        else 
        {
            throw Pattern.UnexpectedValueError.init()
        }

        return value 
    }
}
