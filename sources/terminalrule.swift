public
protocol TerminalRule:ParsingRule
{
    static 
    func parse(terminal:Terminal) -> Construction?
}
extension TerminalRule
{
    @inlinable public static 
    func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws -> Construction
        where Grammar.Parsable<Location, Terminal, Diagnostics>:Any
    {
        guard let terminal:Terminal     = input.next()
        else 
        {
            throw Grammar.Expected<Self>.init()
        }
        guard let value:Construction    = Self.parse(terminal: terminal)
        else 
        {
            throw Grammar.Expected<Self>.init()
        }
        return value 
    }
}
