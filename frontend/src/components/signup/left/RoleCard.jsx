// src/components/common/RoleCard.jsx

function RoleCard({ label, description, icon, value, register, selected }) {
  return (
    <label className={`role-card ${selected ? "active" : ""}`}>
      <input
        type="radio"
        value={value}
        {...register("role")}
        hidden
      />

      <div className="role-content">
        <div className="icon">{icon}</div>
        <div>
          <h4>{label}</h4>
          <p>{description}</p>
        </div>
      </div>
    </label>
  );
}

export default RoleCard;