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
    enum StartOfHeader:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x01) }
    }
    
    public
    enum Backslash:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x5c) }
    }
    public
    enum BraceLeft:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x7b) }
    }
    public 
    enum BraceRight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x7d) }
    }
    public
    enum BracketLeft:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x5b) }
    }
    public 
    enum BracketRight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x5d) }
    }
    public
    enum Colon:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x3a) }
    }
    public
    enum Comma:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x2c) }
    }
    public
    enum Dollar:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x24) }
    }
    public
    enum Equals:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x3d) }
    }
    public
    enum Minus:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x2d) }
    }
    public
    enum Period:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x2e) }
    }
    public
    enum Quote:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x22) }
    }
    public
    enum Space:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x20) }
    }
    
    public 
    enum E 
    {
        public 
        enum Anycase:TerminalRule 
        {
            public 
            typealias Construction  = Void
            @inlinable public static 
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
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<UInt8> { .init(0x78) }
        }
    }
    public 
    enum U
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<UInt8> { .init(0x75) }
        }
    }
    
    public
    enum Zero:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x30) }
    }
    public
    enum One:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x31) }
    }
    public
    enum Two:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x32) }
    }
    public
    enum Three:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x33) }
    }
    public
    enum Four:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x34) }
    }
    public
    enum Five:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x35) }
    }
    public
    enum Six:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x36) }
    }
    public
    enum Seven:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x37) }
    }
    public
    enum Eight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<UInt8> { .init(0x38) }
    }
    public
    enum Nine:LiteralRule
    {
        @inlinable public static 
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
    enum Decimal:DigitRule 
    {
        @inlinable public static 
        var radix:Construction 
        {
            10
        }
        @inlinable public static 
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
        enum Lowercase:DigitRule 
        {
            @inlinable public static 
            var radix:Construction 
            {
                16
            }
            @inlinable public static 
            func parse(terminal:UInt8) -> Construction?
            {
                switch terminal 
                {
                case 0x30 ... 0x39: return Construction.init(terminal - 0x30)
                case 0x61 ... 0x66: return Construction.init(terminal +   10 - 0x61)
                default:            return nil
                }
            }
        }
        public 
        enum Anycase:DigitRule 
        {
            @inlinable public static 
            var radix:Construction 
            {
                16
            }
            @inlinable public static 
            func parse(terminal:UInt8) -> Construction?
            {
                switch terminal 
                {
                case 0x30 ... 0x39: return Construction.init(terminal - 0x30)
                case 0x61 ... 0x66: return Construction.init(terminal +   10 - 0x61)
                case 0x41 ... 0x46: return Construction.init(terminal +   10 - 0x41)
                default:            return nil
                }
            }
        }
    }
} 
