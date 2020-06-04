import React from "react";

import { Bar } from "@nivo/bar";

const Chart = ({ metric, dimension, data }) => {
  console.log(data);
  return (
    <Bar
      data={data}
      keys={[metric]}
      height={400}
      width={600}
      indexBy={dimension}
      margin={{ top: 30, right: 0, bottom: 50, left: 60 }}
      padding={0.3}
      colors={{ scheme: "pastel2" }}
      colorBy="index"
      axisTop={null}
      axisRight={null}
      axisLeft={null}
      axisBottom={null}
      enableLabel={false}
      animate={true}
      motionStiffness={90}
      motionDamping={15}
    />
  );
};

export default Chart;
