/// A generic context for unicode definitions.
public 
enum UnicodeEncoding<Location, Terminal> 
{
}
extension UnicodeEncoding where Terminal:ASCIITerminal 
{
    /// Parses a newline; either a ``Linefeed`` or a ``CarriageReturn`` followed by a 
    /// ``Linefeed``.
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

    @available(*, deprecated)
    public 
    typealias StartOfHeader = StartOfHeading 

    @available(*, deprecated)
    public 
    typealias Quote = DoubleQuote 

    @available(*, deprecated)
    public 
    typealias And = Ampersand 

    @available(*, deprecated)
    public 
    typealias Minus = Hyphen 

    @available(*, unavailable)
    public 
    typealias Pound = Hashtag 

    @available(*, unavailable)
    public 
    typealias Apostrophe = SingleQuote 

    @available(*, unavailable)
    public 
    typealias HyphenMinus = Hyphen 

    @available(*, unavailable)
    public 
    typealias FullStop = Period 

    @available(*, unavailable)
    public 
    typealias Solidus = Slash 

    @available(*, unavailable)
    public 
    typealias LessThan = AngleLeft 

    @available(*, unavailable)
    public 
    typealias GreaterThan = AngleRight 

    @available(*, unavailable)
    public 
    typealias VerticalBar = Pipe 

    public
    enum Null:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x00)) }
    }

    public
    enum StartOfHeading:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x01)) }
    }

    public
    enum StartOfText:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x02)) }
    }

    public
    enum EndOfText:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x03)) }
    }

    public
    enum EndOfTransmission:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x04)) }
    }

    public
    enum Enquiry:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x05)) }
    }

    public
    enum Acknowledgement:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x06)) }
    }

    public
    enum Bell:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x07)) }
    }

    public
    enum Backspace:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x08)) }
    }

    public
    enum HorizontalTab:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x09)) }
    }

    public
    enum Linefeed:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x0a)) }
    }

    public
    enum VerticalTab:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x0b)) }
    }

    public
    enum Formfeed:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x0c)) }
    }

    public
    enum CarriageReturn:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x0d)) }
    }

    public
    enum ShiftOut:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x0e)) }
    }

    public
    enum ShiftIn:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x0f)) }
    }

    public
    enum DataLinkEscape:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x10)) }
    }

    public
    enum DeviceControl1:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x11)) }
    }

    public
    enum DeviceControl2:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x12)) }
    }

    public
    enum DeviceControl3:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x13)) }
    }

    public
    enum DeviceControl4:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x14)) }
    }

    public
    enum NegativeAcknowledgement:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x15)) }
    }

    public
    enum SynchronousIdle:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x16)) }
    }

    public
    enum EndOfTransmissionBlock:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x17)) }
    }

    public
    enum Cancel:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x18)) }
    }

    public
    enum EndOfMedium:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x19)) }
    }

    public
    enum Substitute:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x1a)) }
    }

    public
    enum Escape:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x1b)) }
    }

    public
    enum FileSeparator:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x1c)) }
    }

    public
    enum GroupSeparator:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x1d)) }
    }

    public
    enum RecordSeparator:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x1e)) }
    }

    public
    enum UnitSeparator:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x1f)) }
    }

    public
    enum Space:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x20)) }
    }

    public
    enum Exclamation:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x21)) }
    }

    public
    enum DoubleQuote:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x22)) }
    }

    public
    enum Hashtag:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x23)) }
    }

    public
    enum Dollar:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x24)) }
    }

    public
    enum Percent:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x25)) }
    }

    public
    enum Ampersand:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x26)) }
    }

    public
    enum SingleQuote:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x27)) }
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
    enum Asterisk:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x2a)) }
    }

    public
    enum Plus:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x2b)) }
    }

    public
    enum Comma:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x2c)) }
    }

    public
    enum Hyphen:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x2d)) }
    }

    public
    enum Period:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x2e)) }
    }

    public
    enum Slash:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x2f)) }
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
    enum Colon:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x3a)) }
    }

    public
    enum Semicolon:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x3b)) }
    }

    public
    enum AngleLeft:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x3c)) }
    }

    public
    enum Equals:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x3d)) }
    }

    public
    enum AngleRight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x3e)) }
    }

    public
    enum Question:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x3f)) }
    }

    public
    enum At:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x40)) }
    }

    public
    enum BracketLeft:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x5b)) }
    }

    public
    enum Backslash:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x5c)) }
    }

    public
    enum BracketRight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x5d)) }
    }

    public
    enum Caret:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x5e)) }
    }

    public
    enum Underscore:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x5f)) }
    }

    public
    enum Backtick:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x60)) }
    }

    public
    enum BraceLeft:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x7b)) }
    }

    public
    enum Pipe:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x7c)) }
    }

    public
    enum BraceRight:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x7d)) }
    }

    public
    enum Tilde:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x7e)) }
    }

    public
    enum Delete:LiteralRule
    {
        @inlinable public static 
        var literal:CollectionOfOne<Terminal> { .init(.init(0x7f)) }
    }

    public 
    enum A:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x61)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x41)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x41), .init(0x61): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum B:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x62)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x42)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x42), .init(0x62): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum C:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x63)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x43)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x43), .init(0x63): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum D:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x64)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x44)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x44), .init(0x64): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum E:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x65)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x45)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x45), .init(0x65): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum F:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x66)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x46)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x46), .init(0x66): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum G:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x67)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x47)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x47), .init(0x67): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum H:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x68)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x48)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x48), .init(0x68): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum I:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x69)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x49)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x49), .init(0x69): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum J:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x6a)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x4a)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x4a), .init(0x6a): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum K:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x6b)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x4b)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x4b), .init(0x6b): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum L:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x6c)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x4c)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x4c), .init(0x6c): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum M:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x6d)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x4d)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x4d), .init(0x6d): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum N:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x6e)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x4e)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x4e), .init(0x6e): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum O:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x6f)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x4f)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x4f), .init(0x6f): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum P:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x70)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x50)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x50), .init(0x70): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum Q:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x71)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x51)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x51), .init(0x71): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum R:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x72)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x52)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x52), .init(0x72): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum S:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x73)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x53)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x53), .init(0x73): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum T:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x74)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x54)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x54), .init(0x74): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum U:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x75)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x55)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x55), .init(0x75): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum V:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x76)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x56)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x56), .init(0x76): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum W:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x77)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x57)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x57), .init(0x77): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum X:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x78)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x58)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x58), .init(0x78): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum Y:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x79)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x59)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x59), .init(0x79): 
                return ()
            default:
                return nil
            }
        }
    }

    public 
    enum Z:TerminalRule
    {
        public
        enum Lowercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x7a)) }
        }
        public
        enum Uppercase:LiteralRule 
        {
            @inlinable public static 
            var literal:CollectionOfOne<Terminal> { .init(.init(0x5a)) }
        }
        
        public 
        typealias Construction  = Void

        @inlinable public static 
        func parse(terminal:Terminal) -> Void?
        {
            switch terminal 
            {
            case .init(0x5a), .init(0x7a): 
                return ()
            default:
                return nil
            }
        }
    }
}