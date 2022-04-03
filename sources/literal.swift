/// A terminal type that can be matched against an ASCII scalar.
public 
protocol ASCIITerminal:Equatable
{
    init(_:UInt8)
}
public 
protocol UTF8Terminal:ASCIITerminal
{
}
public 
protocol UTF16Terminal:ASCIITerminal
{
    init(_:UInt16)
}
public 
protocol UnicodeTerminal:ASCIITerminal
{
    init(_:Unicode.Scalar)
}
public 
protocol CharacterTerminal:UnicodeTerminal
{
    init(_:Character)
}

extension UInt8:UTF8Terminal
{
}
extension UInt16:UTF16Terminal 
{
}
/* extension UInt32:UnicodeTerminal 
{
} */
extension Unicode.Scalar:UnicodeTerminal 
{
}
/* extension Character:CharacterTerminal 
{
} */


extension Grammar.Encoding where Terminal:ASCIITerminal
{
    public
    enum StartOfHeader:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x01)) }
    }
    
    public
    enum And:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x26)) }
    }
    public
    enum AngleLeft:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x3c)) }
    }
    public
    enum AngleRight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x3e)) }
    }
    public
    enum Backslash:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x5c)) }
    }
    public
    enum BraceLeft:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x7b)) }
    }
    public 
    enum BraceRight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x7d)) }
    }
    public
    enum BracketLeft:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x5b)) }
    }
    public 
    enum BracketRight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x5d)) }
    }
    public
    enum Colon:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x3a)) }
    }
    public
    enum Comma:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x2c)) }
    }
    public
    enum Dollar:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x24)) }
    }
    public
    enum Equals:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x3d)) }
    }
    public
    enum Linefeed:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x0a)) }
    }
    public
    enum Minus:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x2d)) }
    }
    public
    enum ParenthesisLeft:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x28)) }
    }
    public
    enum ParenthesisRight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x29)) }
    }
    public
    enum Percent:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x25)) }
    }
    public
    enum Period:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x2e)) }
    }
    public
    enum Plus:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x2b)) }
    }
    public
    enum Quote:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x22)) }
    }
    public
    enum Question:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x3f)) }
    }
    public
    enum CarriageReturn:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x0d)) }
    }
    public
    enum Slash:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x2f)) }
    }
    public
    enum Space:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x20)) }
    }
    
    public 
    enum E:TerminalRule
    {
        public 
        typealias Construction  = Void
        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x65), .init(0x45): 
                return ()
            default:
                return nil
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
            var literal:CollectionOfOne<Terminal> { .init(.init(0x78)) }
        }
    }
    public 
    enum U
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x75)) }
        }
    }
    
    public
    enum Zero:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x30)) }
    }
    public
    enum One:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x31)) }
    }
    public
    enum Two:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x32)) }
    }
    public
    enum Three:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x33)) }
    }
    public
    enum Four:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x34)) }
    }
    public
    enum Five:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x35)) }
    }
    public
    enum Six:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x36)) }
    }
    public
    enum Seven:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x37)) }
    }
    public
    enum Eight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x38)) }
    }
    public
    enum Nine:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x39)) }
    }
    public 
    typealias Hyphen = Minus
    
    public 
    enum Newline:ParsingRule 
    {
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws 
            where   Diagnostics:ParsingDiagnostics,
                    Diagnostics.Source.Index == Location,
                    Diagnostics.Source.Element == Terminal
        {
            if case nil = input.parse(as: Linefeed?.self) 
            {
                try input.parse(as: (CarriageReturn, Linefeed).self)
            }
        }
    }
}
