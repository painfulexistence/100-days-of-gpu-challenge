@group(0) @binding(0) var<storage, read_write> a : array<f32>;
@group(0) @binding(1) var<storage, read_write> out : array<f32>;

const wgs = vec3({{workgroupSize}}); // workgroup sizes
const twg = vec3({{totalWorkgroups}}); // total workgroups
var<workgroup> smem: array<f32, {{smemSize}}>;

@compute @workgroup_size({{workgroupSize}})
fn main(@builtin(local_invocation_id) lid: vec3<u32>,
        @builtin(global_invocation_id) gid: vec3<u32>,
        @builtin(workgroup_id) wid: vec3<u32>) {
  if (lid.x < arrayLength(&a)) {
    smem[lid.x] = a[lid.x];
  }
  workgroupBarrier();

  if (lid.x < arrayLength(&a)) {
    out[lid.x] = smem[lid.x];
    if (lid.x > 1) {
      out[lid.x] += smem[lid.x - 1];
      if (lid.x > 2) {
        out[lid.x] += smem[lid.x - 2];
      }
    }
  }  
}
