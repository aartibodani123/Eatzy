import { useWatch } from "react-hook-form";
import RoleCard from "./RoleCard";

function RoleSelector({ control, register }) {
  // 👇 This watches selected role in real-time
  const selectedRole = useWatch({
    control,
    name: "role",
  });

  return (
    <div className="role-selection">
      <RoleCard
        label="Customer"
        description="Order delicious food easily"
        icon="👤"
        value="CUSTOMER"
        register={register}
        selected={selectedRole === "CUSTOMER"}
      />

      <RoleCard
        label="Restaurant Owner"
        description="Manage your restaurant & orders"
        icon="🏪"
        value="RESTAURANT_OWNER"
        register={register}
        selected={selectedRole === "RESTAURANT_OWNER"}
      />
    </div>
  );
}

export default RoleSelector;