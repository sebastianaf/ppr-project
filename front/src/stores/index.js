//Redux
import { createStore } from "redux";
import reducer from "../reducers";

const initialState = {
  app: { name: `generic-front` },
  user: {
    name: `generic-front`,
    role: `generic-role`,
  },
  open: true,
};

export const store = createStore(reducer, initialState);
