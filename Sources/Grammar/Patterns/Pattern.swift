/// A namespace for structured parsing utilities.
public 
enum Pattern 
{
    /// A rule that expects the end of the input. 
    /// 
    /// >   Throws: ``UnexpectedValueError`` if there is any 
    ///     input remaining.
    public
    enum End<Location, Terminal>:ParsingRule 
    {
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws 
        where   Diagnostics:ParsingDiagnostics, 
                Diagnostics.Source.Index == Location, 
                Diagnostics.Source.Element == Terminal
        {
            if let _:Terminal = input.next() 
            {
                throw UnexpectedValueError.init()
            }
        }
    }
    /// A rule that unconditionally ignores all remaining input.
    /// 
    /// This rule never throws an error.
    public 
    enum Discard<Rule>:ParsingRule 
        where   Rule:ParsingRule, Rule.Construction == Void
    {
        public 
        typealias Location = Rule.Location
        public 
        typealias Terminal = Rule.Terminal 
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) 
        where   Diagnostics:ParsingDiagnostics, 
                Diagnostics.Source.Index == Location, 
                Diagnostics.Source.Element == Terminal
        {
            input.parse(as: Rule.self, in: Void.self)
        }
    }
    public 
    enum Collect<Rule, Construction>:ParsingRule 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection
    {
        public 
        typealias Location = Rule.Location
        public 
        typealias Terminal = Rule.Terminal 
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) -> Construction
        where   Diagnostics:ParsingDiagnostics, 
                Diagnostics.Source.Index == Location, 
                Diagnostics.Source.Element == Terminal
        {
            input.parse(as: Rule.self, in: Construction.self)
        }
    }
    public 
    enum Reduce<Rule, Construction>:ParsingRule 
        where   Rule:ParsingRule, Rule.Construction == Construction.Element,
                Construction:RangeReplaceableCollection
    {
        public 
        typealias Location = Rule.Location
        public 
        typealias Terminal = Rule.Terminal 
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws -> Construction
        where   Diagnostics:ParsingDiagnostics, 
                Diagnostics.Source.Index == Location, 
                Diagnostics.Source.Element == Terminal
        {
            var vector:Construction = .init()
                vector.append(try input.parse(as: Rule.self))
            while let next:Rule.Construction = input.parse(as: Rule?.self)
            {
                vector.append(next)
            }
            return vector
        }
    }
    public 
    enum Join<Rule, Separator, Construction>:ParsingRule
        where   Rule:ParsingRule, Separator:ParsingRule,
                Rule.Location == Separator.Location, 
                Rule.Terminal == Separator.Terminal, 
                Separator.Construction == Void, 
                Rule.Construction == Construction.Element, 
                Construction:RangeReplaceableCollection
    {
        public 
        typealias Terminal = Rule.Terminal
        public 
        typealias Location = Rule.Location
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws -> Construction
        where   Diagnostics:ParsingDiagnostics, 
                Diagnostics.Source.Index == Location, 
                Diagnostics.Source.Element == Terminal
        {
            var vector:Construction = .init()
                vector.append(try input.parse(as: Rule.self))
            while let (_, next):(Void, Rule.Construction)  = try? input.parse(as: (Separator, Rule).self)
            {
                vector.append(next)
            }
            return vector
        }
    }
    public 
    enum Pad<Rule, Padding>:ParsingRule
        where   Rule:ParsingRule, Padding:ParsingRule, 
                Rule.Location == Padding.Location,
                Rule.Terminal == Padding.Terminal, 
                Padding.Construction == Void
    {
        public 
        typealias Terminal = Rule.Terminal
        public 
        typealias Location = Rule.Location
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws -> Rule.Construction
        where   Diagnostics:ParsingDiagnostics, 
                Diagnostics.Source.Index == Location, 
                Diagnostics.Source.Element == Terminal
        {
            input.parse(as: Padding.self, in: Void.self)
            let construction:Rule.Construction = try input.parse(as: Rule.self) 
            input.parse(as: Padding.self, in: Void.self)
            return construction
        }
    }

    public
    typealias UnsignedInteger<Digit> = UnsignedNormalizedInteger<Digit, Digit>
        where Digit:DigitRule, Digit.Construction:FixedWidthInteger
    
    public
    enum UnsignedNormalizedInteger<First, Next>:ParsingRule
    where   First:ParsingRule, Next:DigitRule, Next.Construction:FixedWidthInteger, 
            First.Construction == Next.Construction, 
            First.Location == Next.Location, 
            First.Terminal == Next.Terminal
    {
        public
        typealias Location = First.Location
        public
        typealias Terminal = First.Terminal
        
        @inlinable public static 
        func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws -> Next.Construction
        where   Diagnostics:ParsingDiagnostics, 
                Diagnostics.Source.Index == Location, 
                Diagnostics.Source.Element == Terminal
        {
            var value:Next.Construction = try input.parse(as: First.self)
            while let remainder:Next.Construction = input.parse(as: Next?.self)
            {
                guard   case (let shifted, false) = value.multipliedReportingOverflow(by: Next.radix), 
                        case (let refined, false) = shifted.addingReportingOverflow(remainder)
                else 
                {
                    throw IntegerOverflowError<Next.Construction>.init()
                }
                value = refined
            }
            return value
        }
    }
}