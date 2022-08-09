package com.example.lumberstore.services;

import com.example.lumberstore.entity.Image;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

@Service
@Transactional
public class ImageStorageService {


    public Image getImageFile(MultipartFile file) throws IOException {

        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        MultipartFile fileResized = crop(file, 600, 800);

        Image image = new Image(fileName, file.getContentType(), fileResized.getBytes());

        return image;
    }

    private MultipartFile crop(MultipartFile file, int targetWidth, int targetHeight) throws IOException{

        BufferedImage image = ImageIO.read(file.getInputStream());

        int type = (image.getTransparency() == Transparency.OPAQUE) ? BufferedImage.TYPE_INT_RGB : BufferedImage.TYPE_INT_ARGB;

        BufferedImage resultImage = image;
        BufferedImage scratchImage = null;
        Graphics2D graphics2D = null;

        int width = image.getWidth();
        int height = image.getHeight();

        int prevWidth = width;
        int prevHeight = height;

        do {
            if (width > targetWidth) {
                width /= 2;
                width = Math.max(width, targetWidth);
            }

            if (height > targetHeight) {
                height /= 2;
                height = Math.max(height, targetHeight);
            }

            if (scratchImage == null) {
                scratchImage = new BufferedImage(width, height, type);
                graphics2D = scratchImage.createGraphics();
            }

            graphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
                    RenderingHints.VALUE_INTERPOLATION_BILINEAR);
            graphics2D.drawImage(resultImage, 0, 0, width, height, 0, 0, prevWidth, prevHeight, null);

            prevWidth = width;
            prevHeight = height;
            resultImage = scratchImage;
        } while (width != targetWidth || height != targetHeight);

        if (graphics2D != null) {
            graphics2D.dispose();
        }

        if (targetWidth != resultImage.getWidth() || targetHeight != resultImage.getHeight()) {
            scratchImage = new BufferedImage(targetWidth, targetHeight, type);
            graphics2D = scratchImage.createGraphics();
            graphics2D.drawImage(resultImage, 0, 0, null);
            graphics2D.dispose();
            resultImage = scratchImage;
        }

        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        ImageIO.write(resultImage, "jpg", byteArrayOutputStream);
        byteArrayOutputStream.flush();

        return new MultipartImage(byteArrayOutputStream.toByteArray());
    }

    private static class MultipartImage implements MultipartFile {


        private byte[] bytes;
        String name;
        String originalFilename;
        String contentType;
        boolean isEmpty;
        long size;

        public MultipartImage(byte[] bytes, String name, String originalFilename, String contentType,
                              long size) {
            this.bytes = bytes;
            this.name = name;
            this.originalFilename = originalFilename;
            this.contentType = contentType;
            this.size = size;
            this.isEmpty = false;
        }

        public MultipartImage(byte[] bytes) {
            this.bytes = bytes;
        }

        @Override
        public String getName() {
            return name;
        }

        @Override
        public String getOriginalFilename() {
            return originalFilename;
        }

        @Override
        public String getContentType() {
            return contentType;
        }

        @Override
        public boolean isEmpty() {
            return isEmpty;
        }

        @Override
        public long getSize() {
            return size;
        }

        @Override
        public byte[] getBytes() throws IOException {
            return bytes;
        }

        @Override
        public InputStream getInputStream() throws IOException {
            // TODO Auto-generated method stub
            return null;
        }

        @Override
        public void transferTo(File dest) throws IOException, IllegalStateException {
            // TODO Auto-generated method stub

        }
    }
}
