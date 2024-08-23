const { PrismaClient } = require('@prisma/client');
const fs = require('fs');

const prisma = new PrismaClient();

interface JsonData {
  title: string;
  meta_description: string;
  product_name: string;
  tagline: string;
  featured_image: string;
  product_logo: string;
  product_url: string;
  short_description: string;
  full_description: string;
  how_it_works: string;
  category: string;
  user_sentiments?: { positive: string[]; negative: string[] };
  media?: { demo_videos: string[]; screenshots: string[] };
  call_to_action?: { text: string; url: string; anchor_text: string };
  contact_information?: { support_email: string; phone_number: string };
  pros?: string[];
  cons?: string[];
  payment_options?: string[];
  tags: string[];
  platforms_and_availability?: string;
  privacy_and_security?: string;
  restrictions?: string;
  features_and_benefits?: Array<{ title: string; description: string }>;
  unique_selling_points?: Array<{ title: string; description: string }>;
  ai_capabilities?: Array<{ keyword: string; title: string; description: string; url: string; source: string; createdAt: string }>;
  target_audience?: Array<{ name: string }>;
  pricing?: {
    model: string;
    free_tier: boolean;
    free_trial: boolean;
    premium_plans: Array<{ name: string; price: string; features: string[] }>;
  };
  user_reviews?: Array<{ rating: number; comment: string }>;
  faq?: Array<{ question: string; answer: string }>;
  related_links?: Array<{ url: string; anchor_text: string }>;
}

async function main() {
  console.log("Starting seed process...");
  try {
    const rawData = fs.readFileSync('./data/Airops-sa-clean.json', 'utf8').trim();
    console.log('Raw data (first 100 characters):', rawData.substring(0, 100));
    
    const jsonData: JsonData = JSON.parse(rawData);
    console.log('Parsed data (first 100 characters):', JSON.stringify(jsonData).substring(0, 100));

    await prisma.aggregatorTool.create({
      data: {
        title: jsonData.title,
        metaDescription: jsonData.meta_description,
        productName: jsonData.product_name,
        tagline: jsonData.tagline,
        featuredImage: jsonData.featured_image,
        productLogo: jsonData.product_logo,
        productUrl: jsonData.product_url,
        shortDescription: jsonData.short_description,
        fullDescription: jsonData.full_description,
        howItWorks: jsonData.how_it_works,
        category: jsonData.category,
        positiveUserSentiments: jsonData.user_sentiments?.positive || [],
        negativeUserSentiments: jsonData.user_sentiments?.negative || [],
        demoVideos: jsonData.media?.demo_videos || [],
        screenshots: jsonData.media?.screenshots || [],
        ctaText: jsonData.call_to_action?.text || '',
        ctaUrl: jsonData.call_to_action?.url || '',
        ctaAnchorText: jsonData.call_to_action?.anchor_text || '',
        supportEmail: jsonData.contact_information?.support_email || '',
        phoneNumber: jsonData.contact_information?.phone_number || '',
        pros: jsonData.pros || [],
        cons: jsonData.cons || [],
        paymentOptions: jsonData.payment_options || [],
        tags: jsonData.tags || [],
        platformsAvailability: jsonData.platforms_and_availability || '',
        privacyAndSecurity: jsonData.privacy_and_security || '',
        restrictions: jsonData.restrictions || '',
        rating: 0,
        featured: false,
        verified: false,
        featuresAndBenefits: {
          create: jsonData.features_and_benefits?.map((fb) => ({
            title: fb.title,
            description: fb.description
          })) || []
        },
        uniqueSellingPoints: {
          create: jsonData.unique_selling_points?.map((usp) => ({
            title: usp.title,
            description: usp.description
          })) || []
        },
        aiCapabilities: {
          create: jsonData.ai_capabilities?.map((ac) => ({
            keyword: ac.keyword || 'default keyword', // Ensure this field is included
            title: ac.title,
            description: ac.description,
            url: ac.url || 'default url',
            source: ac.source || 'default source',
            createdAt: isNaN(Date.parse(ac.createdAt)) ? new Date() : new Date(ac.createdAt) // Ensure valid date
          })) || []
        },
        targetAudiences: {
          create: jsonData.target_audience?.map((ta) => ({
            name: ta.name || 'default name'
          })) || []
        },
        pricing: {
          create: {
            model: jsonData.pricing?.model || '',
            freeTier: jsonData.pricing?.free_tier || '',
            freeTrial: jsonData.pricing?.free_trial || '',
            premiumPlans: {
              create: jsonData.pricing?.premium_plans?.map((pp) => ({
                name: pp.name,
                price: parseFloat(pp.price.replace('$', '').replace(' per month', '')),
                features: pp.features.join(', ')
              })) || []
            }
          }
        },
        userReviews: {
          create: jsonData.user_reviews?.map((ur) => ({
            rating: ur.rating || 0,
            comment: ur.comment || 'default comment'
          })) || []
        },
        faq: {
          create: jsonData.faq?.map((faq) => ({
            question: faq.question,
            answer: faq.answer
          })) || []
        },
        relatedLinks: {
          create: jsonData.related_links?.map((link) => ({
            url: link.url,
            anchor_text: link.anchor_text || 'default anchor text'  // Handle both old and new data formats
          })) || []
        }
      }
    });

    console.log('Seed data inserted successfully');
  } catch (error) {
    console.error('Error in seed process:', error);
  }
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });