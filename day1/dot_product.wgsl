@group(0) @binding(0) var<storage, read_write> a : array<f32>;
@group(0) @binding(1) var<storage, read_write> b : array<f32>;
@group(0) @binding(2) var<storage, read_write> out : array<f32>;

const wgs = vec3({{workgroupSize}});
const twg = vec3({{totalWorkgroups}});
var<workgroup> smem: array<f32, {{smemSize}}>;

@compute @workgroup_size({{workgroupSize}})
fn  main(@builtin(local_invocation_id) lid: vec3<u32>,
         @builtin(global_invocation_id) gid: vec3<u32>) {
  smem[lid.x] = a[lid.x] * b[lid.x];
  workgroupBarrier();
  out[lid.x] = 0;
  for (var i: u32 = 0; i < wgs.x; i++) {
    out[lid.x] += smem[i];
  }
}
