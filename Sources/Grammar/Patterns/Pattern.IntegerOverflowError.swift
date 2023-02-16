extension Pattern
{
    /// An integer overflow error occurred while applying one of the 
    /// built-in integer parsing rules.
    @frozen public
    struct IntegerOverflowError<Integer>:Error, CustomStringConvertible 
        where Integer:FixedWidthInteger
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
            "Parsed value overflows integer type '\(Integer.self)'."
        }
    }
}
