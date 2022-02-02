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
    enum Backslash:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x5c) }
    }
    public
    enum BraceLeft:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x7b) }
    }
    public 
    enum BraceRight:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x7d) }
    }
    public
    enum BracketLeft:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x5b) }
    }
    public 
    enum BracketRight:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x5d) }
    }
    public
    enum Colon:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x3a) }
    }
    public
    enum Comma:Grammar.TerminalSequence
    {
        public static 
        var literal:CollectionOfOne<UInt8> { .init(0x2c) }
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
    enum E 
    {
        public 
        enum Anycase:Grammar.TerminalClass 
        {
            public 
            typealias Construction  = Void
            public static 
            func parse(terminal:UInt8) -> Void?
            {
                switch terminal 
                {
                case 0x65, 0x45:    return ()
                default:            return nil
                }
            }
        }
    }
    public 
    enum X
    {
        public
        enum Lowercase:Grammar.TerminalSequence 
        {
            public static 
            var literal:CollectionOfOne<UInt8> { .init(0x78) }
        }
    }
    public 
    enum U
    {
        public
        enum Lowercase:Grammar.TerminalSequence 
        {
            public static 
            var literal:CollectionOfOne<UInt8> { .init(0x75) }
        }
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
    public 
    enum Hex 
    {
        public 
        enum Lowercase:Grammar.DigitRule 
        {
            public static 
            var radix:Construction 
            {
                16
            }
            public static 
            func parse(terminal:UInt8) -> Construction?
            {
                switch terminal 
                {
                case 0x30 ... 0x39: return Construction.init(terminal - 0x30)
                case 0x61 ... 0x66: return Construction.init(terminal + 0xa0 - 0x61)
                default:            return nil
                }
            }
        }
        public 
        enum Anycase:Grammar.DigitRule 
        {
            public static 
            var radix:Construction 
            {
                16
            }
            public static 
            func parse(terminal:UInt8) -> Construction?
            {
                switch terminal 
                {
                case 0x30 ... 0x39: return Construction.init(terminal - 0x30)
                case 0x61 ... 0x66: return Construction.init(terminal + 0xa0 - 0x61)
                case 0x41 ... 0x46: return Construction.init(terminal + 0xa0 - 0x41)
                default:            return nil
                }
            }
        }
    }
} 
