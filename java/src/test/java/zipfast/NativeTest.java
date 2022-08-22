package zipfast;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import org.junit.jupiter.api.Test;

public class NativeTest {
    @Test
    void testLibdeflateInflate() {
        long inflater = Native.libdeflate_inflater_alloc();
        byte[] decodeded = Base64.getDecoder().decode("HcwxDsMgEETR3qeYjnOk9AmilCgsGBl2pGUJ8u3jpP767ynBBEoMt6hFbMCJxo9sL06cygU/BDabDERNGEQi9u2BPFvDm71X76IeBtYRHXvo91L1rFrA/HcWZ0saHEX8Fweysd/eBd68oczrCw==");
        ByteBuffer ndecoded = ByteBuffer.allocateDirect(decodeded.length);
        ndecoded.put(decodeded);
        ndecoded.position(0);
        ByteBuffer expected = ByteBuffer.wrap("We're no strangers to love\nYou know the rules and so do I\nA full commitment's what I'm thinking of\nYou wouldn't get this from any other guy".getBytes(StandardCharsets.UTF_8));
        byte[] inflated = new byte[expected.capacity()];
        Native.libdeflate_inflate(inflater, ndecoded, 0, ndecoded.capacity(), inflated, 0, inflated.length);
        assertEquals(expected, ByteBuffer.wrap(inflated));
        Native.libdeflate_inflater_free(inflater);
    }
}
