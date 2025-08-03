@group(0) @binding(0) var<storage, read_write> a : array<f32>;
@group(0) @binding(1) var<storage, read_write> out : array<f32>;

@compute @workgroup_size({{workgroupSize}})
fn main(@builtin(local_invocation_id) lid: vec3<u32>) {
  let len = arrayLength(&a);
  if (lid.x > len) {
    return;
  }
  out[lid.x] = 10 + a[lid.x];
}
