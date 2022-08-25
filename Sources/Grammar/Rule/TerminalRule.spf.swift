
#if swift(>=5.7)
/// A parsing rule that is applied to a single terminal at a time.
public
protocol TerminalRule<Terminal, Construction>:ParsingRule
{
    static 
    func parse(terminal:Terminal) -> Construction?
}
#else 
/// A parsing rule that is applied to a single terminal at a time.
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
        if  let terminal:Terminal = input.next(),
            let value:Construction = Self.parse(terminal: terminal)
        {
            return value 
        }
        else 
        {
            throw Pattern.ApplicationError<Self>.init()
        }
    }
}
