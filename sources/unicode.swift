extension Grammar.Encoding where Terminal == Unicode.Scalar
{
    public 
    enum Newline:ParsingRule 
    {
        public 
        typealias Terminal = Unicode.Scalar
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws 
            where   Diagnostics:ParsingDiagnostics,
                    Diagnostics.Source.Index == Location,
                    Diagnostics.Source.Element == Terminal
        {
            if let _:Void = input.parse(as: Linefeed?.self) 
            {
            }
            else 
            {
                try input.parse(as: (Return, Linefeed).self)
            }
        }
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
            func parse(terminal:Unicode.Scalar) -> Void?
            {
                switch terminal 
                {
                case "e", "E":  return ()
                default:        return nil
                }
            }
        }
    }
    
    public
    enum AngleLeft:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("<") }
    }
    public
    enum AngleRight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(">") }
    }
    
    public
    enum Backslash:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("\\") }
    }
    public
    enum BracketLeft:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("[") }
    }
    public
    enum BracketRight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("]") }
    }
    
    public
    enum And:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("&") }
    }
    public
    enum BraceLeft:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("{") }
    }
    public
    enum BraceRight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("}") }
    }
    
    public
    enum Colon:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(":") }
    }
    public
    enum Comma:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(",") }
    }
    public
    enum Dollar:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("$") }
    }
    public
    enum Equals:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("=") }
    }
    public
    enum Linefeed:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("\n") }
    }
    public
    enum Minus:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("-") }
    }
    
    public
    enum ParenthesisLeft:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("(") }
    }
    public
    enum ParenthesisRight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(")") }
    }
    
    public
    enum Percent:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("%") }
    }
    public
    enum Period:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init(".") }
    }
    public
    enum Plus:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("+") }
    }
    public
    enum Quote:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("\"") }
    }
    public 
    enum Question:LiteralRule 
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("?") }
    }
    public
    enum Return:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("\r") }
    }
    public
    enum Slash:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("/") }
    }
    public
    enum Zero:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Unicode.Scalar> { .init("0") }
    }
    public 
    typealias Hyphen = Minus
    public 
    enum X
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Unicode.Scalar> { .init("x") }
        }
    }
    public 
    enum U
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Unicode.Scalar> { .init("u") }
        }
    }
    public 
    enum Whitespace:TerminalRule 
    {
        public 
        typealias Construction  = Void
        @inlinable public static 
        func parse(terminal:Unicode.Scalar) -> Void?
        {
            terminal.properties.isWhitespace ? () : nil
        }
    }
}
extension Grammar.Digit where Terminal == Unicode.Scalar
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
        func parse(terminal:Terminal) -> Construction?
        {
            switch terminal 
            {
            case "0":   return 0
            case "1":   return 1
            case "2":   return 2
            case "3":   return 3
            case "4":   return 4
            case "5":   return 5
            case "6":   return 6
            case "7":   return 7
            case "8":   return 8
            case "9":   return 9
            default:    return nil
            }
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
            func parse(terminal:Unicode.Scalar) -> Construction?
            {
                switch terminal 
                {
                case "0" ... "9":
                    return Construction.init(terminal.value      - ("0" as Unicode.Scalar).value)
                case "a" ... "f":
                    return Construction.init(terminal.value + 10 - ("a" as Unicode.Scalar).value)
                default:
                    return nil
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
            func parse(terminal:Unicode.Scalar) -> Construction?
            {
                switch terminal 
                {
                case "0" ... "9":
                    return Construction.init(terminal.value      - ("0" as Unicode.Scalar).value)
                case "a" ... "f":
                    return Construction.init(terminal.value + 10 - ("a" as Unicode.Scalar).value)
                case "A" ... "F":
                    return Construction.init(terminal.value + 10 - ("A" as Unicode.Scalar).value)
                default:
                    return nil
                }
            }
        }
    }
}
