/* extension Unicode 
{
    enum Latin1
    {
    }
}
extension Unicode.Latin1 
{
    struct Printable<Location>:Grammar.TerminalClass
    {
        typealias Terminal      = UInt8 
        typealias Construction  = UInt8 
        static 
        func parse(terminal codepoint:UInt8) -> UInt8?
        {
            guard 0x20 ... 0x7e ~= codepoint || 0xa0 <= codepoint
            else 
            {
                return nil 
            }
            return codepoint
        }
    }
} */
