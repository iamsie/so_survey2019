import React from "react";

import { ResponsiveBarCanvas } from "@nivo/bar";

const Bar = ({ metric, dimension, data }) => {
  console.log(data);
  return (
    <ResponsiveBarCanvas
      data={data}
      keys={[metric]}
      indexBy={dimension}
      margin={{ top: 10, right: 0, bottom: 10, left: 10 }}
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

const Chart = ({ metric, dimension, data }) => {
  return (
    <div style={{ height: 400 }}>
      <Bar data={data} metric={metric} dimension={dimension} />
    </div>
  );
};

export default Chart;
