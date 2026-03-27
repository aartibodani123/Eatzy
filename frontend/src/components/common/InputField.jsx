function InputField({ label, type = "text", register, name, errors, validation = {} }) {
    return (
        <div className="input-group">
            <input
                type={type}
                placeholder={label}
                {...register(name, {
                    required: `${label} is requred`,
                    ...validation,
                })}
            />
            {errors[name] && (
                <p className="error">{errors[name].message}</p>
            )}
        </div>
    );
}

export default InputField;