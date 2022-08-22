package zipfast;

import java.io.IOException;
import java.io.InputStream;
import java.io.UncheckedIOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Locale;

public class Native {
    private Native() { }

    static final String VERSION = "2";

    static {
        try {
            // https://github.com/java-native-access/jna/blob/bf60e51eace6dffa18548019e2ba398ff84904ef/src/com/sun/jna/Platform.java
            String os_arch = System.getProperty("os.arch");
            String arch;
            switch (os_arch) {
                case "i386":
                case "i686":
                case "x86":
                    arch = "i386";
                    break;
                case "x86_64":
                case "x86-64": // is this real?
                case "amd64":
                    arch = "x86_64";
                    break;
                case "powerpc64":
                case "ppc64":
                    if ("little".equals(System.getProperty("sun.cpu.endian"))) {
                        arch = "powerpc64le";
                        break;
                    } else {
                        throw new UnknownPlatformException("ppc64be not supported");
                    }
                case "powerpc64le":
                case "ppc64le":
                    arch = "powerpc64le";
                    break;
                case "aarch64":
                    arch = "aarch64";
                    break;
                default:
                    throw new UnknownPlatformException("Unknown arch: " + os_arch);
            }
            String osString = System.getProperty("os.name", "generic").toLowerCase(Locale.ENGLISH);
            String os;
            String libraryname;
            if ((osString.indexOf("mac") >= 0) || (osString.indexOf("darwin") >= 0)) {
                os = "macos-none";
                libraryname = "libzipfast.dylib";
            } else if (osString.indexOf("win") >= 0) {
                os = "windows-gnu";
                libraryname = "zipfast.dll";
            } else if (osString.indexOf("nux") >= 0) {
                os = "linux-gnu";
                libraryname = "libzipfast.so";
            } else {
                throw new UnknownPlatformException("Unknown os: " + osString); // Minecraft requires natives so knowing the os is required
            }
            String triple = arch + "-" + os;
            URL url = Native.class.getClassLoader().getResource("zipfastnatives/" + triple + "/" + libraryname);
            Path nativePath;
            if ("file".equals(url.getProtocol())) {
                try {
                    nativePath = Paths.get(url.toURI());
                } catch (URISyntaxException e) {
                    throw new RuntimeException(e);
                }
            } else {
                Path dir = Paths.get(""/*CWD*/).toAbsolutePath().resolve(VERSION).resolve(triple);
                Files.createDirectories(dir);
                nativePath = dir.resolve(libraryname);
                if (!nativePath.toFile().exists()) {
                    try (InputStream is = url.openStream()) {
                        Files.copy(is, nativePath);
                    }
                }
            }
            System.load(nativePath.toFile().getCanonicalPath());
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    public static long libdeflate_inflater_alloc() {
        long r = libdeflate_inflater_alloc0();
        if (r == 0) throw new NullPointerException();
        return r;
    }

    private static native long libdeflate_inflater_alloc0();

    public static native void libdeflate_inflater_free(long ptr);

    public static void libdeflate_inflate(long inflater, ByteBuffer src, int src_pos, int src_size, byte[] dst, int dst_pos, int dst_size) {
        if (src_pos < 0 || src_pos >= src.capacity()) {
            throw new IndexOutOfBoundsException("Invalid src_start");
        }
        if (src_size < 0 || src_pos + src_size > src.capacity()) {
            throw new IndexOutOfBoundsException("Invalid src_end");
        }
        if (dst_pos < 0 || dst_pos >= dst.length) {
            throw new IndexOutOfBoundsException("Invalid dst_pos");
        }
        if (dst_size < 0 || dst_pos + dst_size > dst.length) {
            throw new IndexOutOfBoundsException("Invalid dst_size");
        }
        int r = libdeflate_inflate0(inflater, src, src_pos, src_size, dst, dst_pos, dst_size);
        if (r != 0) {
            throw new RuntimeException("Failed to inflate " + r);
        }
    }

    private static native int libdeflate_inflate0(long inflater, ByteBuffer src, int src_start, int src_size, byte[] dst, int dst_pos, int dst_size);
}
