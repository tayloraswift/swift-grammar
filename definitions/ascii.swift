extension Grammar.Encoding where Terminal == UInt8 
{
    enum ASCII 
    {
    }
}
extension Grammar.Encoding.ASCII 
{
    enum StartOfHeader:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x01) }
    }
    
    enum Colon:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x3a) }
    }
    enum Equals:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x3d) }
    }
    enum Minus:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x2d) }
    }
    enum Period:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x2e) }
    }
    enum Quote:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x22) }
    }
    enum Space:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x20) }
    }
    
    enum Zero:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x30) }
    }
    enum One:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x31) }
    }
    enum Two:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x32) }
    }
    enum Three:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x33) }
    }
    enum Four:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x34) }
    }
    enum Five:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x35) }
    }
    enum Six:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x36) }
    }
    enum Seven:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x37) }
    }
    enum Eight:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x38) }
    }
    enum Nine:Grammar.TerminalSequence
    {
        static 
        var literal:CollectionOfOne<UInt8> { .init(0x39) }
    }
    
    typealias Hyphen = Minus
}
extension Grammar.Digit where Terminal == UInt8 
{
    enum ASCII
    {
    }
}
extension Grammar.Digit.ASCII
{
    enum Decimal:Grammar.DigitRule 
    {
        static 
        var radix:Construction 
        {
            10
        }
        static 
        func parse(terminal codepoint:UInt8) -> Construction? 
        {
            guard 0x30 ... 0x39 ~= codepoint 
            else 
            {
                return nil 
            }
            return .init(codepoint - 0x30)
        }
    }
} 
