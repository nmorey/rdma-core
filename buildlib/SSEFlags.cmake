# check for SSE extensions
include(CheckCSourceRuns)
set(SSE_FLAGS)

set(CMAKE_REQUIRED_FLAGS "-msse")
check_c_source_compiles("
  #include <xmmintrin.h>
  int main()
  {
      __m128 a, b;
      float vals[4] = {0};
      a = _mm_loadu_ps(vals);
      b = a;
      b = _mm_add_ps(a,b);
      _mm_storeu_ps(vals,b);
      return 0;
  }"
  HAS_SSE_EXTENSIONS)

set(CMAKE_REQUIRED_FLAGS)

if(HAS_SSE_EXTENSIONS)
  set(SSE_FLAGS "-msse -DHAVE_SSE_EXTENSIONS")
endif()

add_definitions(${SSE_FLAGS})
