#include <metal_stdlib>
using namespace metal;

vertex float4 myVertexShader(const device float2 * vertex_array [[ buffer(0) ]],
                             uint vid [[ vertex_id ]]) {
    
    
    return float4(vertex_array[vid],0,1);
}


fragment float4 myFragmentShader() {
    
    return float4(1.0, 0.0, 1.0, 1.0);
}