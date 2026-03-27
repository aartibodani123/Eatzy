import {useForm} from "react-hook-form";
import InputField from "../../common/InputField";
import RoleSelector from "./RoleSelector";
import "../../../styles/auth.css";
import axios from "axios";

function SignUpForm(){
    const {
        register,
        handleSubmit,
        control,
        formState:{errors},
    } =useForm ({
        defaultValues:{
            role:"CUSTOMER",
        },
    });
    const onSubmit=async (data) =>{
        console.log(data);
        try{
            const response=await axios.post(
                "http://localhost:8080/auth/register",
                {
                    firstName: data.firstName,
                    lastName: data.lastName,
                    email: data.email,
                    role: data.role,
                    password: data.password, 
                }
            );
            console.log("Success:",response.data);
        }catch(error){
            console.error("Error:",error.response?.data || error.message);
        }
    };
    return (
        <form onSubmit={handleSubmit(onSubmit)}>
            <div className="input-row">
                <InputField
                    label="First Name"
                    name ="firstName"
                    register={register}
                    errors={errors}
                />
                 <InputField
                    label="Last Name"
                    name ="lastName"
                    register={register}
                    errors={errors}
                />
            </div>
            <InputField
                label="Email"
                type="email"
                name="email"
                register={register}
                errors={errors}
            />

             <InputField
                    label="Password"
                    name ="password"
                    type="password"
                    register={register}
                    errors={errors}
                    validation={{
                        minLength:{
                            value:6,
                            message: "Password must be at least 6 characters",
                        },
                    }}
                />
                <RoleSelector control={control} register={register} />
                <button type ="submit">Sign Up</button>

        </form>
    )
}
export default SignUpForm;



