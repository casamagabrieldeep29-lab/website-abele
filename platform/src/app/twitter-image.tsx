import { renderShareImage } from "@/lib/brand-image";

export const alt = "ABELIEVER — ABE Licensure Exam Review";
export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

export default function Image() {
  return renderShareImage(size.width, size.height);
}
