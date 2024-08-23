/*
  Warnings:

  - You are about to drop the column `details` on the `Pricing` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `Pricing` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Pricing" DROP COLUMN "details",
DROP COLUMN "type",
ADD COLUMN     "freeTier" TEXT,
ADD COLUMN     "freeTrial" TEXT,
ADD COLUMN     "model" TEXT;

-- CreateTable
CREATE TABLE "PremiumPlan" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "features" TEXT NOT NULL,
    "pricingId" TEXT NOT NULL,

    CONSTRAINT "PremiumPlan_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "PremiumPlan" ADD CONSTRAINT "PremiumPlan_pricingId_fkey" FOREIGN KEY ("pricingId") REFERENCES "Pricing"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
