const reducer = (state, action) => {
  switch (action.type) {
    case "SET_OPEN":
      return {
        ...state,
        open: !state.open,
      };
    case "SET_HIDESIDEBAR":
      return {
        ...state,
        hideSidebar: !state.hideSidebar,
      };
    default:
      return state;
  }
};

export default reducer;
