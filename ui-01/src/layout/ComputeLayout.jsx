import React from "react";

const ComputeLayout = () => {
  return (
    <div className={`flex justify-center items-start w-full`}>
      <div className={`flex flex-row flex-wrap max-w-[1280px] w-full`}>
        <div
          className={`p-1 md:p-2 w-full  h-[700px] md:h-[700px] lg:h-[700px] `}
        >
          <div
            className={`w-full h-full shadow border rounded-lg  overflow-hidden`}
          ></div>
        </div>
      </div>
    </div>
  );
};

export default ComputeLayout;
