/// A generic context for unicode definitions.
public
enum UnicodeEncoding<Location, Terminal>
{
}
extension UnicodeEncoding where Terminal:ASCIITerminal
{
    @available(*, unavailable, renamed: "StartOfHeading")
    public
    typealias StartOfHeader = StartOfHeading

    @available(*, unavailable, renamed: "DoubleQuote")
    public
    typealias Quote = DoubleQuote

    @available(*, unavailable, renamed: "Ampersand")
    public
    typealias And = Ampersand

    @available(*, unavailable, renamed: "Hyphen")
    public
    typealias Minus = Hyphen

    @available(*, unavailable, renamed: "Hashtag")
    public
    typealias Pound = Hashtag

    @available(*, unavailable, renamed: "SingleQuote")
    public
    typealias Apostrophe = SingleQuote

    @available(*, unavailable, renamed: "Hyphen")
    public
    typealias HyphenMinus = Hyphen

    @available(*, unavailable, renamed: "Period")
    public
    typealias FullStop = Period

    @available(*, unavailable, renamed: "Slash")
    public
    typealias Solidus = Slash

    @available(*, unavailable, renamed: "AngleLeft")
    public
    typealias LessThan = AngleLeft

    @available(*, unavailable, renamed: "AngleRight")
    public
    typealias GreaterThan = AngleRight

    @available(*, unavailable, renamed: "Pipe")
    public
    typealias VerticalBar = Pipe

    /// Matches the ASCII/Unicode codepoint `0x00`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Null` character.
    public
    enum Null:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x00) }
    }

    /// Matches the ASCII/Unicode codepoint `0x01`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `StartOfHeading` character.
    public
    enum StartOfHeading:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x01) }
    }

    /// Matches the ASCII/Unicode codepoint `0x02`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `StartOfText` character.
    public
    enum StartOfText:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x02) }
    }

    /// Matches the ASCII/Unicode codepoint `0x03`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `EndOfText` character.
    public
    enum EndOfText:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x03) }
    }

    /// Matches the ASCII/Unicode codepoint `0x04`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `EndOfTransmission` character.
    public
    enum EndOfTransmission:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x04) }
    }

    /// Matches the ASCII/Unicode codepoint `0x05`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Enquiry` character.
    public
    enum Enquiry:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x05) }
    }

    /// Matches the ASCII/Unicode codepoint `0x06`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Acknowledgement` character.
    public
    enum Acknowledgement:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x06) }
    }

    /// Matches the ASCII/Unicode codepoint `0x07`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Bell` character.
    public
    enum Bell:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x07) }
    }

    /// Matches the ASCII/Unicode codepoint `0x08`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Backspace` character.
    public
    enum Backspace:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x08) }
    }

    /// Matches the ASCII/Unicode codepoint `0x09`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `HorizontalTab` character.
    public
    enum HorizontalTab:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x09) }
    }

    /// Matches the ASCII/Unicode codepoint `0x0a`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Linefeed` character.
    public
    enum Linefeed:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x0a) }
    }

    /// Matches the ASCII/Unicode codepoint `0x0b`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `VerticalTab` character.
    public
    enum VerticalTab:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x0b) }
    }

    /// Matches the ASCII/Unicode codepoint `0x0c`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Formfeed` character.
    public
    enum Formfeed:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x0c) }
    }

    /// Matches the ASCII/Unicode codepoint `0x0d`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `CarriageReturn` character.
    public
    enum CarriageReturn:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x0d) }
    }

    /// Matches the ASCII/Unicode codepoint `0x0e`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `ShiftOut` character.
    public
    enum ShiftOut:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x0e) }
    }

    /// Matches the ASCII/Unicode codepoint `0x0f`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `ShiftIn` character.
    public
    enum ShiftIn:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x0f) }
    }

    /// Matches the ASCII/Unicode codepoint `0x10`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `DataLinkEscape` character.
    public
    enum DataLinkEscape:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x10) }
    }

    /// Matches the ASCII/Unicode codepoint `0x11`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `DeviceControl1` character.
    public
    enum DeviceControl1:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x11) }
    }

    /// Matches the ASCII/Unicode codepoint `0x12`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `DeviceControl2` character.
    public
    enum DeviceControl2:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x12) }
    }

    /// Matches the ASCII/Unicode codepoint `0x13`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `DeviceControl3` character.
    public
    enum DeviceControl3:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x13) }
    }

    /// Matches the ASCII/Unicode codepoint `0x14`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `DeviceControl4` character.
    public
    enum DeviceControl4:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x14) }
    }

    /// Matches the ASCII/Unicode codepoint `0x15`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `NegativeAcknowledgement` character.
    public
    enum NegativeAcknowledgement:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x15) }
    }

    /// Matches the ASCII/Unicode codepoint `0x16`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `SynchronousIdle` character.
    public
    enum SynchronousIdle:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x16) }
    }

    /// Matches the ASCII/Unicode codepoint `0x17`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `EndOfTransmissionBlock` character.
    public
    enum EndOfTransmissionBlock:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x17) }
    }

    /// Matches the ASCII/Unicode codepoint `0x18`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Cancel` character.
    public
    enum Cancel:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x18) }
    }

    /// Matches the ASCII/Unicode codepoint `0x19`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `EndOfMedium` character.
    public
    enum EndOfMedium:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x19) }
    }

    /// Matches the ASCII/Unicode codepoint `0x1a`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Substitute` character.
    public
    enum Substitute:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x1a) }
    }

    /// Matches the ASCII/Unicode codepoint `0x1b`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Escape` character.
    public
    enum Escape:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x1b) }
    }

    /// Matches the ASCII/Unicode codepoint `0x1c`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `FileSeparator` character.
    public
    enum FileSeparator:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x1c) }
    }

    /// Matches the ASCII/Unicode codepoint `0x1d`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `GroupSeparator` character.
    public
    enum GroupSeparator:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x1d) }
    }

    /// Matches the ASCII/Unicode codepoint `0x1e`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `RecordSeparator` character.
    public
    enum RecordSeparator:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x1e) }
    }

    /// Matches the ASCII/Unicode codepoint `0x1f`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `UnitSeparator` character.
    public
    enum UnitSeparator:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x1f) }
    }

    /// Matches the ASCII/Unicode codepoint `0x20`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Space` character.
    public
    enum Space:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x20) }
    }

    /// Matches the ASCII/Unicode codepoint `0x21`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Exclamation` character.
    public
    enum Exclamation:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x21) }
    }

    /// Matches the ASCII/Unicode codepoint `0x22`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `DoubleQuote` character.
    public
    enum DoubleQuote:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x22) }
    }

    /// Matches the ASCII/Unicode codepoint `0x23`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Hashtag` character.
    public
    enum Hashtag:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x23) }
    }

    /// Matches the ASCII/Unicode codepoint `0x24`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Dollar` character.
    public
    enum Dollar:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x24) }
    }

    /// Matches the ASCII/Unicode codepoint `0x25`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Percent` character.
    public
    enum Percent:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x25) }
    }

    /// Matches the ASCII/Unicode codepoint `0x26`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Ampersand` character.
    public
    enum Ampersand:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x26) }
    }

    /// Matches the ASCII/Unicode codepoint `0x27`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `SingleQuote` character.
    public
    enum SingleQuote:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x27) }
    }

    /// Matches the ASCII/Unicode codepoint `0x28`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `ParenthesisLeft` character.
    public
    enum ParenthesisLeft:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x28) }
    }

    /// Matches the ASCII/Unicode codepoint `0x29`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `ParenthesisRight` character.
    public
    enum ParenthesisRight:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x29) }
    }

    /// Matches the ASCII/Unicode codepoint `0x2a`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Asterisk` character.
    public
    enum Asterisk:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x2a) }
    }

    /// Matches the ASCII/Unicode codepoint `0x2b`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Plus` character.
    public
    enum Plus:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x2b) }
    }

    /// Matches the ASCII/Unicode codepoint `0x2c`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Comma` character.
    public
    enum Comma:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x2c) }
    }

    /// Matches the ASCII/Unicode codepoint `0x2d`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Hyphen` character.
    public
    enum Hyphen:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x2d) }
    }

    /// Matches the ASCII/Unicode codepoint `0x2e`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Period` character.
    public
    enum Period:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x2e) }
    }

    /// Matches the ASCII/Unicode codepoint `0x2f`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Slash` character.
    public
    enum Slash:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x2f) }
    }

    /// Matches the ASCII/Unicode codepoint `0x30`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Zero` character.
    public
    enum Zero:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x30) }
    }

    /// Matches the ASCII/Unicode codepoint `0x31`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `One` character.
    public
    enum One:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x31) }
    }

    /// Matches the ASCII/Unicode codepoint `0x32`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Two` character.
    public
    enum Two:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x32) }
    }

    /// Matches the ASCII/Unicode codepoint `0x33`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Three` character.
    public
    enum Three:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x33) }
    }

    /// Matches the ASCII/Unicode codepoint `0x34`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Four` character.
    public
    enum Four:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x34) }
    }

    /// Matches the ASCII/Unicode codepoint `0x35`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Five` character.
    public
    enum Five:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x35) }
    }

    /// Matches the ASCII/Unicode codepoint `0x36`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Six` character.
    public
    enum Six:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x36) }
    }

    /// Matches the ASCII/Unicode codepoint `0x37`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Seven` character.
    public
    enum Seven:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x37) }
    }

    /// Matches the ASCII/Unicode codepoint `0x38`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Eight` character.
    public
    enum Eight:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x38) }
    }

    /// Matches the ASCII/Unicode codepoint `0x39`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Nine` character.
    public
    enum Nine:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x39) }
    }

    /// Matches the ASCII/Unicode codepoint `0x3a`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Colon` character.
    public
    enum Colon:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x3a) }
    }

    /// Matches the ASCII/Unicode codepoint `0x3b`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Semicolon` character.
    public
    enum Semicolon:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x3b) }
    }

    /// Matches the ASCII/Unicode codepoint `0x3c`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `AngleLeft` character.
    public
    enum AngleLeft:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x3c) }
    }

    /// Matches the ASCII/Unicode codepoint `0x3d`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Equals` character.
    public
    enum Equals:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x3d) }
    }

    /// Matches the ASCII/Unicode codepoint `0x3e`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `AngleRight` character.
    public
    enum AngleRight:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x3e) }
    }

    /// Matches the ASCII/Unicode codepoint `0x3f`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Question` character.
    public
    enum Question:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x3f) }
    }

    /// Matches the ASCII/Unicode codepoint `0x40`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `At` character.
    public
    enum At:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x40) }
    }

    /// Matches the ASCII/Unicode codepoint `0x5b`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `BracketLeft` character.
    public
    enum BracketLeft:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x5b) }
    }

    /// Matches the ASCII/Unicode codepoint `0x5c`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Backslash` character.
    public
    enum Backslash:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x5c) }
    }

    /// Matches the ASCII/Unicode codepoint `0x5d`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `BracketRight` character.
    public
    enum BracketRight:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x5d) }
    }

    /// Matches the ASCII/Unicode codepoint `0x5e`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Caret` character.
    public
    enum Caret:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x5e) }
    }

    /// Matches the ASCII/Unicode codepoint `0x5f`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Underscore` character.
    public
    enum Underscore:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x5f) }
    }

    /// Matches the ASCII/Unicode codepoint `0x60`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Backtick` character.
    public
    enum Backtick:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x60) }
    }

    /// Matches the ASCII/Unicode codepoint `0x7b`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `BraceLeft` character.
    public
    enum BraceLeft:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x7b) }
    }

    /// Matches the ASCII/Unicode codepoint `0x7c`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Pipe` character.
    public
    enum Pipe:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x7c) }
    }

    /// Matches the ASCII/Unicode codepoint `0x7d`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `BraceRight` character.
    public
    enum BraceRight:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x7d) }
    }

    /// Matches the ASCII/Unicode codepoint `0x7e`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Tilde` character.
    public
    enum Tilde:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x7e) }
    }

    /// Matches the ASCII/Unicode codepoint `0x7f`.
    ///
    /// All ``ASCIITerminal`` types can match a(n) `Delete` character.
    public
    enum Delete:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x7f) }
    }

    /// Matches the letter `'A'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'A'`.
    /// The two valid codepoint values are `0x41` (`'A'`)
    /// and `0x61` (`'a'`).
    ///
    /// To match `'A'` or `'a'` exactly, use the
    /// ``UppercaseA`` or
    /// ``LowercaseA`` rules.
    public
    enum A:TerminalRule
    {
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
    /// Matches the lowercase letter `'a'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'a'`
    /// (`0x61`).
    public
    enum LowercaseA:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x61) }
    }
    /// Matches the uppercase letter `'A'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'A'`
    /// (`0x41`).
    public
    enum UppercaseA:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x41) }
    }

    /// Matches the letter `'B'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'B'`.
    /// The two valid codepoint values are `0x42` (`'B'`)
    /// and `0x62` (`'b'`).
    ///
    /// To match `'B'` or `'b'` exactly, use the
    /// ``UppercaseB`` or
    /// ``LowercaseB`` rules.
    public
    enum B:TerminalRule
    {
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
    /// Matches the lowercase letter `'b'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'b'`
    /// (`0x62`).
    public
    enum LowercaseB:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x62) }
    }
    /// Matches the uppercase letter `'B'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'B'`
    /// (`0x42`).
    public
    enum UppercaseB:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x42) }
    }

    /// Matches the letter `'C'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'C'`.
    /// The two valid codepoint values are `0x43` (`'C'`)
    /// and `0x63` (`'c'`).
    ///
    /// To match `'C'` or `'c'` exactly, use the
    /// ``UppercaseC`` or
    /// ``LowercaseC`` rules.
    public
    enum C:TerminalRule
    {
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
    /// Matches the lowercase letter `'c'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'c'`
    /// (`0x63`).
    public
    enum LowercaseC:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x63) }
    }
    /// Matches the uppercase letter `'C'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'C'`
    /// (`0x43`).
    public
    enum UppercaseC:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x43) }
    }

    /// Matches the letter `'D'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'D'`.
    /// The two valid codepoint values are `0x44` (`'D'`)
    /// and `0x64` (`'d'`).
    ///
    /// To match `'D'` or `'d'` exactly, use the
    /// ``UppercaseD`` or
    /// ``LowercaseD`` rules.
    public
    enum D:TerminalRule
    {
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
    /// Matches the lowercase letter `'d'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'d'`
    /// (`0x64`).
    public
    enum LowercaseD:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x64) }
    }
    /// Matches the uppercase letter `'D'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'D'`
    /// (`0x44`).
    public
    enum UppercaseD:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x44) }
    }

    /// Matches the letter `'E'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'E'`.
    /// The two valid codepoint values are `0x45` (`'E'`)
    /// and `0x65` (`'e'`).
    ///
    /// To match `'E'` or `'e'` exactly, use the
    /// ``UppercaseE`` or
    /// ``LowercaseE`` rules.
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
            case .init(0x45), .init(0x65):
                return ()
            default:
                return nil
            }
        }
    }
    /// Matches the lowercase letter `'e'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'e'`
    /// (`0x65`).
    public
    enum LowercaseE:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x65) }
    }
    /// Matches the uppercase letter `'E'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'E'`
    /// (`0x45`).
    public
    enum UppercaseE:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x45) }
    }

    /// Matches the letter `'F'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'F'`.
    /// The two valid codepoint values are `0x46` (`'F'`)
    /// and `0x66` (`'f'`).
    ///
    /// To match `'F'` or `'f'` exactly, use the
    /// ``UppercaseF`` or
    /// ``LowercaseF`` rules.
    public
    enum F:TerminalRule
    {
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
    /// Matches the lowercase letter `'f'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'f'`
    /// (`0x66`).
    public
    enum LowercaseF:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x66) }
    }
    /// Matches the uppercase letter `'F'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'F'`
    /// (`0x46`).
    public
    enum UppercaseF:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x46) }
    }

    /// Matches the letter `'G'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'G'`.
    /// The two valid codepoint values are `0x47` (`'G'`)
    /// and `0x67` (`'g'`).
    ///
    /// To match `'G'` or `'g'` exactly, use the
    /// ``UppercaseG`` or
    /// ``LowercaseG`` rules.
    public
    enum G:TerminalRule
    {
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
    /// Matches the lowercase letter `'g'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'g'`
    /// (`0x67`).
    public
    enum LowercaseG:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x67) }
    }
    /// Matches the uppercase letter `'G'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'G'`
    /// (`0x47`).
    public
    enum UppercaseG:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x47) }
    }

    /// Matches the letter `'H'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'H'`.
    /// The two valid codepoint values are `0x48` (`'H'`)
    /// and `0x68` (`'h'`).
    ///
    /// To match `'H'` or `'h'` exactly, use the
    /// ``UppercaseH`` or
    /// ``LowercaseH`` rules.
    public
    enum H:TerminalRule
    {
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
    /// Matches the lowercase letter `'h'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'h'`
    /// (`0x68`).
    public
    enum LowercaseH:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x68) }
    }
    /// Matches the uppercase letter `'H'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'H'`
    /// (`0x48`).
    public
    enum UppercaseH:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x48) }
    }

    /// Matches the letter `'I'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'I'`.
    /// The two valid codepoint values are `0x49` (`'I'`)
    /// and `0x69` (`'i'`).
    ///
    /// To match `'I'` or `'i'` exactly, use the
    /// ``UppercaseI`` or
    /// ``LowercaseI`` rules.
    public
    enum I:TerminalRule
    {
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
    /// Matches the lowercase letter `'i'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'i'`
    /// (`0x69`).
    public
    enum LowercaseI:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x69) }
    }
    /// Matches the uppercase letter `'I'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'I'`
    /// (`0x49`).
    public
    enum UppercaseI:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x49) }
    }

    /// Matches the letter `'J'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'J'`.
    /// The two valid codepoint values are `0x4a` (`'J'`)
    /// and `0x6a` (`'j'`).
    ///
    /// To match `'J'` or `'j'` exactly, use the
    /// ``UppercaseJ`` or
    /// ``LowercaseJ`` rules.
    public
    enum J:TerminalRule
    {
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
    /// Matches the lowercase letter `'j'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'j'`
    /// (`0x6a`).
    public
    enum LowercaseJ:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x6a) }
    }
    /// Matches the uppercase letter `'J'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'J'`
    /// (`0x4a`).
    public
    enum UppercaseJ:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x4a) }
    }

    /// Matches the letter `'K'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'K'`.
    /// The two valid codepoint values are `0x4b` (`'K'`)
    /// and `0x6b` (`'k'`).
    ///
    /// To match `'K'` or `'k'` exactly, use the
    /// ``UppercaseK`` or
    /// ``LowercaseK`` rules.
    public
    enum K:TerminalRule
    {
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
    /// Matches the lowercase letter `'k'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'k'`
    /// (`0x6b`).
    public
    enum LowercaseK:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x6b) }
    }
    /// Matches the uppercase letter `'K'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'K'`
    /// (`0x4b`).
    public
    enum UppercaseK:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x4b) }
    }

    /// Matches the letter `'L'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'L'`.
    /// The two valid codepoint values are `0x4c` (`'L'`)
    /// and `0x6c` (`'l'`).
    ///
    /// To match `'L'` or `'l'` exactly, use the
    /// ``UppercaseL`` or
    /// ``LowercaseL`` rules.
    public
    enum L:TerminalRule
    {
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
    /// Matches the lowercase letter `'l'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'l'`
    /// (`0x6c`).
    public
    enum LowercaseL:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x6c) }
    }
    /// Matches the uppercase letter `'L'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'L'`
    /// (`0x4c`).
    public
    enum UppercaseL:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x4c) }
    }

    /// Matches the letter `'M'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'M'`.
    /// The two valid codepoint values are `0x4d` (`'M'`)
    /// and `0x6d` (`'m'`).
    ///
    /// To match `'M'` or `'m'` exactly, use the
    /// ``UppercaseM`` or
    /// ``LowercaseM`` rules.
    public
    enum M:TerminalRule
    {
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
    /// Matches the lowercase letter `'m'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'m'`
    /// (`0x6d`).
    public
    enum LowercaseM:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x6d) }
    }
    /// Matches the uppercase letter `'M'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'M'`
    /// (`0x4d`).
    public
    enum UppercaseM:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x4d) }
    }

    /// Matches the letter `'N'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'N'`.
    /// The two valid codepoint values are `0x4e` (`'N'`)
    /// and `0x6e` (`'n'`).
    ///
    /// To match `'N'` or `'n'` exactly, use the
    /// ``UppercaseN`` or
    /// ``LowercaseN`` rules.
    public
    enum N:TerminalRule
    {
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
    /// Matches the lowercase letter `'n'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'n'`
    /// (`0x6e`).
    public
    enum LowercaseN:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x6e) }
    }
    /// Matches the uppercase letter `'N'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'N'`
    /// (`0x4e`).
    public
    enum UppercaseN:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x4e) }
    }

    /// Matches the letter `'O'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'O'`.
    /// The two valid codepoint values are `0x4f` (`'O'`)
    /// and `0x6f` (`'o'`).
    ///
    /// To match `'O'` or `'o'` exactly, use the
    /// ``UppercaseO`` or
    /// ``LowercaseO`` rules.
    public
    enum O:TerminalRule
    {
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
    /// Matches the lowercase letter `'o'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'o'`
    /// (`0x6f`).
    public
    enum LowercaseO:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x6f) }
    }
    /// Matches the uppercase letter `'O'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'O'`
    /// (`0x4f`).
    public
    enum UppercaseO:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x4f) }
    }

    /// Matches the letter `'P'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'P'`.
    /// The two valid codepoint values are `0x50` (`'P'`)
    /// and `0x70` (`'p'`).
    ///
    /// To match `'P'` or `'p'` exactly, use the
    /// ``UppercaseP`` or
    /// ``LowercaseP`` rules.
    public
    enum P:TerminalRule
    {
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
    /// Matches the lowercase letter `'p'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'p'`
    /// (`0x70`).
    public
    enum LowercaseP:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x70) }
    }
    /// Matches the uppercase letter `'P'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'P'`
    /// (`0x50`).
    public
    enum UppercaseP:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x50) }
    }

    /// Matches the letter `'Q'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'Q'`.
    /// The two valid codepoint values are `0x51` (`'Q'`)
    /// and `0x71` (`'q'`).
    ///
    /// To match `'Q'` or `'q'` exactly, use the
    /// ``UppercaseQ`` or
    /// ``LowercaseQ`` rules.
    public
    enum Q:TerminalRule
    {
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
    /// Matches the lowercase letter `'q'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'q'`
    /// (`0x71`).
    public
    enum LowercaseQ:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x71) }
    }
    /// Matches the uppercase letter `'Q'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'Q'`
    /// (`0x51`).
    public
    enum UppercaseQ:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x51) }
    }

    /// Matches the letter `'R'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'R'`.
    /// The two valid codepoint values are `0x52` (`'R'`)
    /// and `0x72` (`'r'`).
    ///
    /// To match `'R'` or `'r'` exactly, use the
    /// ``UppercaseR`` or
    /// ``LowercaseR`` rules.
    public
    enum R:TerminalRule
    {
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
    /// Matches the lowercase letter `'r'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'r'`
    /// (`0x72`).
    public
    enum LowercaseR:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x72) }
    }
    /// Matches the uppercase letter `'R'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'R'`
    /// (`0x52`).
    public
    enum UppercaseR:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x52) }
    }

    /// Matches the letter `'S'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'S'`.
    /// The two valid codepoint values are `0x53` (`'S'`)
    /// and `0x73` (`'s'`).
    ///
    /// To match `'S'` or `'s'` exactly, use the
    /// ``UppercaseS`` or
    /// ``LowercaseS`` rules.
    public
    enum S:TerminalRule
    {
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
    /// Matches the lowercase letter `'s'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'s'`
    /// (`0x73`).
    public
    enum LowercaseS:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x73) }
    }
    /// Matches the uppercase letter `'S'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'S'`
    /// (`0x53`).
    public
    enum UppercaseS:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x53) }
    }

    /// Matches the letter `'T'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'T'`.
    /// The two valid codepoint values are `0x54` (`'T'`)
    /// and `0x74` (`'t'`).
    ///
    /// To match `'T'` or `'t'` exactly, use the
    /// ``UppercaseT`` or
    /// ``LowercaseT`` rules.
    public
    enum T:TerminalRule
    {
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
    /// Matches the lowercase letter `'t'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'t'`
    /// (`0x74`).
    public
    enum LowercaseT:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x74) }
    }
    /// Matches the uppercase letter `'T'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'T'`
    /// (`0x54`).
    public
    enum UppercaseT:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x54) }
    }

    /// Matches the letter `'U'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'U'`.
    /// The two valid codepoint values are `0x55` (`'U'`)
    /// and `0x75` (`'u'`).
    ///
    /// To match `'U'` or `'u'` exactly, use the
    /// ``UppercaseU`` or
    /// ``LowercaseU`` rules.
    public
    enum U:TerminalRule
    {
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
    /// Matches the lowercase letter `'u'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'u'`
    /// (`0x75`).
    public
    enum LowercaseU:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x75) }
    }
    /// Matches the uppercase letter `'U'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'U'`
    /// (`0x55`).
    public
    enum UppercaseU:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x55) }
    }

    /// Matches the letter `'V'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'V'`.
    /// The two valid codepoint values are `0x56` (`'V'`)
    /// and `0x76` (`'v'`).
    ///
    /// To match `'V'` or `'v'` exactly, use the
    /// ``UppercaseV`` or
    /// ``LowercaseV`` rules.
    public
    enum V:TerminalRule
    {
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
    /// Matches the lowercase letter `'v'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'v'`
    /// (`0x76`).
    public
    enum LowercaseV:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x76) }
    }
    /// Matches the uppercase letter `'V'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'V'`
    /// (`0x56`).
    public
    enum UppercaseV:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x56) }
    }

    /// Matches the letter `'W'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'W'`.
    /// The two valid codepoint values are `0x57` (`'W'`)
    /// and `0x77` (`'w'`).
    ///
    /// To match `'W'` or `'w'` exactly, use the
    /// ``UppercaseW`` or
    /// ``LowercaseW`` rules.
    public
    enum W:TerminalRule
    {
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
    /// Matches the lowercase letter `'w'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'w'`
    /// (`0x77`).
    public
    enum LowercaseW:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x77) }
    }
    /// Matches the uppercase letter `'W'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'W'`
    /// (`0x57`).
    public
    enum UppercaseW:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x57) }
    }

    /// Matches the letter `'X'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'X'`.
    /// The two valid codepoint values are `0x58` (`'X'`)
    /// and `0x78` (`'x'`).
    ///
    /// To match `'X'` or `'x'` exactly, use the
    /// ``UppercaseX`` or
    /// ``LowercaseX`` rules.
    public
    enum X:TerminalRule
    {
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
    /// Matches the lowercase letter `'x'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'x'`
    /// (`0x78`).
    public
    enum LowercaseX:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x78) }
    }
    /// Matches the uppercase letter `'X'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'X'`
    /// (`0x58`).
    public
    enum UppercaseX:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x58) }
    }

    /// Matches the letter `'Y'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'Y'`.
    /// The two valid codepoint values are `0x59` (`'Y'`)
    /// and `0x79` (`'y'`).
    ///
    /// To match `'Y'` or `'y'` exactly, use the
    /// ``UppercaseY`` or
    /// ``LowercaseY`` rules.
    public
    enum Y:TerminalRule
    {
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
    /// Matches the lowercase letter `'y'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'y'`
    /// (`0x79`).
    public
    enum LowercaseY:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x79) }
    }
    /// Matches the uppercase letter `'Y'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'Y'`
    /// (`0x59`).
    public
    enum UppercaseY:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x59) }
    }

    /// Matches the letter `'Z'`, without case-sensitivity.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'Z'`.
    /// The two valid codepoint values are `0x5a` (`'Z'`)
    /// and `0x7a` (`'z'`).
    ///
    /// To match `'Z'` or `'z'` exactly, use the
    /// ``UppercaseZ`` or
    /// ``LowercaseZ`` rules.
    public
    enum Z:TerminalRule
    {
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
    /// Matches the lowercase letter `'z'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'z'`
    /// (`0x7a`).
    public
    enum LowercaseZ:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x7a) }
    }
    /// Matches the uppercase letter `'Z'`.
    ///
    /// All ``ASCIITerminal`` types can match the letter `'Z'`
    /// (`0x5a`).
    public
    enum UppercaseZ:AtomicRule
    {
        @inlinable public static
        var terminal:Terminal { .init(0x5a) }
    }
}