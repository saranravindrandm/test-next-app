/*
  Warnings:

  - You are about to drop the column `description` on the `RelatedLink` table. All the data in the column will be lost.
  - Added the required column `anchor_text` to the `RelatedLink` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "RelatedLink" ADD COLUMN "anchor_text" TEXT;
UPDATE "RelatedLink" SET "anchor_text" = "description";
ALTER TABLE "RelatedLink" ALTER COLUMN "anchor_text" SET NOT NULL;
ALTER TABLE "RelatedLink" DROP COLUMN "description";