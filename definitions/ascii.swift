extension Grammar.Encoding where Terminal == UInt8 
{
    public 
    enum ASCII 
    {
    }
}
extension Grammar.Encoding.ASCII 
{
    public
    enum StartOfHeader:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x01) }
    }
    
    public
    enum Colon:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x3a) }
    }
    public
    enum Equals:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x3d) }
    }
    public
    enum Minus:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x2d) }
    }
    public
    enum Period:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x2e) }
    }
    public
    enum Quote:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x22) }
    }
    public
    enum Space:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x20) }
    }
    
    public
    enum Zero:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x30) }
    }
    public
    enum One:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x31) }
    }
    public
    enum Two:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x32) }
    }
    public
    enum Three:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x33) }
    }
    public
    enum Four:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x34) }
    }
    public
    enum Five:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x35) }
    }
    public
    enum Six:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x36) }
    }
    public
    enum Seven:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x37) }
    }
    public
    enum Eight:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x38) }
    }
    public
    enum Nine:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x39) }
    }
    public 
    typealias Hyphen = Minus
}
extension Grammar.Digit where Terminal == UInt8 
{
    public 
    enum ASCII
    {
    }
}
extension Grammar.Digit.ASCII
{
    public 
    enum Decimal:Grammar.DigitRule 
    {
        public static 
        var radix:Construction 
        {
            10
        }
        public static 
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
