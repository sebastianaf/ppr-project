import React from "react";
import { Link } from "react-router-dom";

const Button = (props) => {
  const { data } = props;
  return (
    <Link
      to={data.to}
      className="group relative w-full flex justify-center py-2 px-4 border
      border-transparent text-sm font-medium rounded-md text-white bg-cyan-600
      hover:bg-cyan-500 focus:outline-none focus:ring-2 focus:ring-offset-2
      focus:ring-cyan-500 duration-500"
    >
      {data.title}
    </Link>
  );
};

export default Button;
