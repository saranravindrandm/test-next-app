const { PrismaClient } = require('@prisma/client')
const fs = require('fs')

const prisma = new PrismaClient()

async function main() {
    const jsonData = JSON.parse(fs.readFileSync('./data/schema-template-sa.json', 'utf-8'))
  
  for (const item of jsonData) {
    await prisma.user.create({
      data: {
        email: item.email,
        name: item.name,
        posts: {
          create: item.posts.map((post: any) => ({
            title: post.title,
            content: post.content,
            published: post.published
          }))
        }
      }
    })
  }

  console.log('Seed data inserted successfully')
}

main()
  .catch((e) => {
    console.error(e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })