
#if swift(>=5.7)
public
protocol TerminalRule<Terminal, Construction>:ParsingRule
{
    static 
    func parse(terminal:Terminal) -> Construction?
}
#else 
public
protocol TerminalRule:ParsingRule
{
    static 
    func parse(terminal:Terminal) -> Construction?
}
#endif 
extension TerminalRule
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
            throw Pattern.ApplicationError<Self>.init()
        }
        guard let value:Construction    = Self.parse(terminal: terminal)
        else 
        {
            throw Pattern.ApplicationError<Self>.init()
        }
        return value 
    }
}
