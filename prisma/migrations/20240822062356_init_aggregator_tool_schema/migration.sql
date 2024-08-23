/*
  Warnings:

  - The primary key for the `AggregatorTool` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `description` on the `AggregatorTool` table. All the data in the column will be lost.
  - You are about to drop the column `keyword` on the `AggregatorTool` table. All the data in the column will be lost.
  - You are about to drop the column `source` on the `AggregatorTool` table. All the data in the column will be lost.
  - You are about to drop the column `url` on the `AggregatorTool` table. All the data in the column will be lost.
  - Added the required column `featured` to the `AggregatorTool` table without a default value. This is not possible if the table is not empty.
  - Added the required column `productName` to the `AggregatorTool` table without a default value. This is not possible if the table is not empty.
  - Added the required column `rating` to the `AggregatorTool` table without a default value. This is not possible if the table is not empty.
  - Added the required column `slugId` to the `AggregatorTool` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `AggregatorTool` table without a default value. This is not possible if the table is not empty.
  - Added the required column `verified` to the `AggregatorTool` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "AggregatorTool" DROP CONSTRAINT "AggregatorTool_pkey",
DROP COLUMN "description",
DROP COLUMN "keyword",
DROP COLUMN "source",
DROP COLUMN "url",
ADD COLUMN     "category" TEXT,
ADD COLUMN     "cons" TEXT[],
ADD COLUMN     "ctaAnchorText" TEXT,
ADD COLUMN     "ctaText" TEXT,
ADD COLUMN     "ctaUrl" TEXT,
ADD COLUMN     "demoVideos" TEXT[],
ADD COLUMN     "featured" BOOLEAN NOT NULL,
ADD COLUMN     "featuredImage" TEXT,
ADD COLUMN     "fullDescription" TEXT,
ADD COLUMN     "howItWorks" TEXT,
ADD COLUMN     "metaDescription" TEXT,
ADD COLUMN     "negativeUserSentiments" TEXT[],
ADD COLUMN     "paymentOptions" TEXT[],
ADD COLUMN     "phoneNumber" TEXT,
ADD COLUMN     "platformsAvailability" TEXT,
ADD COLUMN     "positiveUserSentiments" TEXT[],
ADD COLUMN     "privacyAndSecurity" TEXT,
ADD COLUMN     "productLogo" TEXT,
ADD COLUMN     "productName" TEXT NOT NULL,
ADD COLUMN     "productUrl" TEXT,
ADD COLUMN     "pros" TEXT[],
ADD COLUMN     "rating" DOUBLE PRECISION NOT NULL,
ADD COLUMN     "releaseDate" TIMESTAMP(3),
ADD COLUMN     "restrictions" TEXT,
ADD COLUMN     "screenshots" TEXT[],
ADD COLUMN     "searchVector" TEXT,
ADD COLUMN     "shortDescription" TEXT,
ADD COLUMN     "slugId" INTEGER NOT NULL,
ADD COLUMN     "supportEmail" TEXT,
ADD COLUMN     "tagline" TEXT,
ADD COLUMN     "tags" TEXT[],
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "verified" BOOLEAN NOT NULL,
ADD COLUMN     "version" TEXT,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "AggregatorTool_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "AggregatorTool_id_seq";

-- CreateTable
CREATE TABLE "FeaturesAndBenefits" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "aggregatorToolId" TEXT NOT NULL,

    CONSTRAINT "FeaturesAndBenefits_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UniqueSellingPoints" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "aggregatorToolId" TEXT NOT NULL,

    CONSTRAINT "UniqueSellingPoints_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AICapabilities" (
    "id" TEXT NOT NULL,
    "keyword" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "aggregatorToolId" TEXT NOT NULL,

    CONSTRAINT "AICapabilities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TargetAudience" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "aggregatorToolId" TEXT NOT NULL,

    CONSTRAINT "TargetAudience_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pricing" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "details" TEXT NOT NULL,
    "aggregatorToolId" TEXT NOT NULL,

    CONSTRAINT "Pricing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserReview" (
    "id" TEXT NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT NOT NULL,
    "aggregatorToolId" TEXT NOT NULL,

    CONSTRAINT "UserReview_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FAQ" (
    "id" TEXT NOT NULL,
    "question" TEXT NOT NULL,
    "answer" TEXT NOT NULL,
    "aggregatorToolId" TEXT NOT NULL,

    CONSTRAINT "FAQ_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RelatedLink" (
    "id" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "aggregatorToolId" TEXT NOT NULL,

    CONSTRAINT "RelatedLink_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Pricing_aggregatorToolId_key" ON "Pricing"("aggregatorToolId");

-- AddForeignKey
ALTER TABLE "FeaturesAndBenefits" ADD CONSTRAINT "FeaturesAndBenefits_aggregatorToolId_fkey" FOREIGN KEY ("aggregatorToolId") REFERENCES "AggregatorTool"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UniqueSellingPoints" ADD CONSTRAINT "UniqueSellingPoints_aggregatorToolId_fkey" FOREIGN KEY ("aggregatorToolId") REFERENCES "AggregatorTool"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AICapabilities" ADD CONSTRAINT "AICapabilities_aggregatorToolId_fkey" FOREIGN KEY ("aggregatorToolId") REFERENCES "AggregatorTool"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TargetAudience" ADD CONSTRAINT "TargetAudience_aggregatorToolId_fkey" FOREIGN KEY ("aggregatorToolId") REFERENCES "AggregatorTool"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pricing" ADD CONSTRAINT "Pricing_aggregatorToolId_fkey" FOREIGN KEY ("aggregatorToolId") REFERENCES "AggregatorTool"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserReview" ADD CONSTRAINT "UserReview_aggregatorToolId_fkey" FOREIGN KEY ("aggregatorToolId") REFERENCES "AggregatorTool"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FAQ" ADD CONSTRAINT "FAQ_aggregatorToolId_fkey" FOREIGN KEY ("aggregatorToolId") REFERENCES "AggregatorTool"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RelatedLink" ADD CONSTRAINT "RelatedLink_aggregatorToolId_fkey" FOREIGN KEY ("aggregatorToolId") REFERENCES "AggregatorTool"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
