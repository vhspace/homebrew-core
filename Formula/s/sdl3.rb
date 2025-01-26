class Sdl3 < Formula
  desc "Low-level access to audio, keyboard, mouse, joystick, and graphics"
  homepage "https://www.libsdl.org/"
  url "https://github.com/libsdl-org/SDL/releases/download/release-3.2.0/SDL3-3.2.0.tar.gz"
  sha256 "bf308f92c5688b1479faf5cfe24af72f3cd4ce08d0c0670d6ce55bc2ec1e9a5e"
  license "Zlib"

  livecheck do
    url :stable
    regex(/release[._-](\d+(?:\.\d+)+)/i)
    strategy :github_latest
  end

  head do
    url "https://github.com/libsdl-org/SDL.git", branch: "main"
    depends_on "cmake" => :build
  end

  depends_on "cmake" => :build

  # TODO
  # bottle do
  #   sha256 cellar: :any,                 arm64_sequoia: "b87f0d34432faf3630ad1f7ed5a65b8387ffadc8eb51c936fe7e973642a8207d"
  #   sha256 cellar: :any,                 arm64_sonoma:  "6eed4d7882ace75c6831382cbadbdeb7cad356cdd5000fad7f0b2e7b17d917f8"
  #   sha256 cellar: :any,                 arm64_ventura: "47101386010f483cb135c3b0caa574c8912777277ec63afdd8216788e8dfc720"
  #   sha256 cellar: :any,                 sonoma:        "eb8211e78231337e7b2a50665a839d46254cac5a6cf6a88cef738ad81f7054cf"
  #   sha256 cellar: :any,                 ventura:       "9809878a8d7eab5b71acb0cdcccc528313896a99972ae251ca693032df7bb427"
  #   sha256 cellar: :any_skip_relocation, x86_64_linux:  "f53ea335f9990ec2aef849a995ea2d7b56db073ea4eb7fb8a34a53e4275d6970"
  # end

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "libice"
    depends_on "libxcursor"
    depends_on "libxscrnsaver"
    depends_on "libxxf86vm"
    depends_on "pulseaudio"
    depends_on "xinput"
  end

  def install
    inreplace "cmake/sdl3.pc.in", "@SDL_PKGCONFIG_PREFIX@", HOMEBREW_PREFIX

    args = std_cmake_args + [
      "-DSDL_HIDAPI=ON",
    ]

    if OS.mac?
      args << "-DSDL_WAYLAND=OFF"
      args << "-DSDL_X11=OFF"
    else
      args << "-DSDL_X11=ON"
      args << "-DSDL_WAYLAND=OFF"
      args << "-DSDL_PULSEAUDIO=ON"
    end

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    system bin/"sdl3-config", "--version"
=======
    (testpath/"test.c").write <<~EOS
      #include <SDL3/SDL.h>
      int main() {
        if (SDL_Init(SDL_INIT_VIDEO) != 1) {
          return 1;
        }
        SDL_Quit();
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lSDL3", "-o", "test"
    ENV["SDL_VIDEODRIVER"] = "dummy"
    system "./test"
>>>>>>> 28ab3629cad (sdl3 3.2.0)
=======
    system bin/"sdl3-config", "--version"
>>>>>>> 4e2cc9c4062 (sdl3 3.2.0)
=======
    system bin/"sdl3-config", "--version"
>>>>>>> ea9206a68af (SDL3)
  end
end
