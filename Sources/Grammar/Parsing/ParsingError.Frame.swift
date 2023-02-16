extension ParsingError
{
    /// A diagnostic stack frame, corresponding to a structured ``ParsingRule`` invocation.
    /// 
    /// Only the ``DefaultDiagnostics`` engine tracks call stack state.
    @frozen public 
    struct Frame 
    {
        /// Indicates the position in the ``ParsingInput.source`` where 
        /// the parser started attempting to apply ``rule``.
        public 
        let index:Index 
        /// The parsing rule associated with this stack frame. 
        /// 
        /// This property is an [`Any`]() metatype, and not a 
        /// ``ParsingRule`` metatype, because this stack frame may have been 
        /// generated by a compound (tuple) rule.
        public 
        let rule:Any.Type 
        /// The ``ParsingRule Construction`` type associated with 
        /// ``rule``, if ``rule`` is a ``ParsingRule``. If ``rule`` is a compound 
        /// (tuple) rule, this property contains a tuple of the same arity, 
        /// containing the ``ParsingRule Construction`` types of each of its 
        /// subrules.
        public 
        let construction:Any.Type 
        /// Creates a stack frame.
        /// -   Parameters:
        ///     - index: An index into an associated input source.
        ///     - rule: A metatype indicating the parsing rule associated with this stack frame.
        ///     - construction: A metatype indicating the expected parsing result of this stack frame.
        @inlinable public 
        init(index:Index, rule:Any.Type, construction:Any.Type)
        {
            self.index          = index 
            self.rule           = rule 
            self.construction   = construction
        }
    }
}
