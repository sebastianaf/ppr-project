import { Navigate } from "react-router-dom";
import { store } from "../stores";

const ProtectedRoute = ({ children }) => {
  return store.getState().user.name ? children : <Navigate to="/login" />;
};

export default ProtectedRoute;
