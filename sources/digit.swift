public
protocol DigitRule:TerminalRule where Construction:BinaryInteger
{    
    static 
    var radix:Construction 
    {
        get 
    }
}

extension Grammar 
{
    public 
    enum DecimalDigit<Location, Terminal, Construction>:DigitRule 
        where Terminal:BinaryInteger, Construction:BinaryInteger
    {
        @inlinable public static 
        var radix:Construction 
        {
            10
        }
        @inlinable public static 
        func parse(terminal:Terminal) -> Construction? 
        {
            guard 0x30 ... 0x39 ~= terminal 
            else 
            {
                return nil 
            }
            return .init(terminal - 0x30)
        }
    }
    public 
    enum HexDigit<Location, Terminal, Construction>:DigitRule 
        where Terminal:BinaryInteger, Construction:BinaryInteger 
    {
        @inlinable public static 
        var radix:Construction 
        {
            16
        }
        @inlinable public static 
        func parse(terminal:Terminal) -> Construction?
        {
            switch terminal 
            {
            case 0x30 ... 0x39: return Construction.init(terminal - 0x30)
            case 0x61 ... 0x66: return Construction.init(terminal +   10 - 0x61)
            case 0x41 ... 0x46: return Construction.init(terminal +   10 - 0x41)
            default:            return nil
            }
        }
        
        public 
        enum Lowercase:DigitRule
        {
            @inlinable public static 
            var radix:Construction 
            {
                16
            }
            @inlinable public static 
            func parse(terminal:Terminal) -> Construction?
            {
                switch terminal 
                {
                case 0x30 ... 0x39: return Construction.init(terminal - 0x30)
                case 0x61 ... 0x66: return Construction.init(terminal +   10 - 0x61)
                default:            return nil
                }
            }
        }
    }
}
extension Grammar
{
    public 
    enum DecimalDigitScalar<Location, Construction> where Construction:BinaryInteger 
    {
        public 
        typealias Terminal = Unicode.Scalar 
        
        @inlinable public static 
        var radix:Construction 
        {
            10
        }
        @inlinable public static 
        func parse(terminal:Unicode.Scalar) -> Construction?
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
    enum HexDigitScalar<Location, Construction> where Construction:BinaryInteger 
    {
        public 
        typealias Terminal = Unicode.Scalar 
        
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
        
        public 
        enum Lowercase:DigitRule
        {
            public 
            typealias Terminal = Unicode.Scalar 
            
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
    }
}

extension Grammar 
{
    @frozen public
    struct IntegerOverflowError<T>:Error, CustomStringConvertible 
    {
        // don’t mark this @inlinable, since we generally don’t expect to 
        // recover from this
        public 
        init()
        {
        }
        public
        var description:String 
        {
            "parsed value overflows integer type '\(T.self)'"
        }
    }
    public
    enum UnsignedIntegerLiteral<Rule>:ParsingRule
        where Rule:DigitRule, Rule.Construction:FixedWidthInteger
    {
        public
        typealias Location = Rule.Location
        public
        typealias Terminal = Rule.Terminal
        
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws -> Rule.Construction
            where   Diagnostics:ParsingDiagnostics,
                    Diagnostics.Source.Index == Location,
                    Diagnostics.Source.Element == Terminal
        {
            var value:Rule.Construction            = try input.parse(as: Rule.self)
            while let remainder:Rule.Construction  =     input.parse(as: Rule?.self)
            {
                guard   case (let shifted, false) = value.multipliedReportingOverflow(by: Rule.radix), 
                        case (let refined, false) = shifted.addingReportingOverflow(remainder)
                else 
                {
                    throw IntegerOverflowError<Rule.Construction>.init()
                }
                value = refined
            }
            return value
        }
    }
}
