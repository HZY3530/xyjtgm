<template>
  <div class="container">
    <header class="header">
      <h1>校园交通革命</h1>
      <p>推动绿色出行，创造便捷生活</p>
    </header>

    <section class="stats">
      <div class="stat-item">
        <h2>交通工具数量</h2>
        <p class="count">1200+</p>
      </div>
      <div class="stat-item">
        <h2>学生参与率</h2>
        <p class="count">85%</p>
      </div>
      <div class="stat-item">
        <h2>减少碳排放</h2>
        <p class="count">150吨</p>
      </div>
    </section>

    <section class="features">
      <div class="feature-card">
        <h3>电动自行车</h3>
        <p>快速、绿色的出行方式，让学生们节省时间，减少碳排放。</p>
      </div>
      <div class="feature-card">
        <h3>智能充电</h3>
        <p>智能充电站遍布校园，为学生提供便捷、高效的电动车充电服务，确保绿色出行无忧。</p>
      </div>
      <div class="feature-card">
        <h3>智慧停车</h3>
        <p>利用智能技术优化校园内的停车资源，减少交通拥堵。</p>
      </div>
    </section>
  </div>
</template>

<script setup>
// 这里可以加入一些脚本逻辑，暂时不需要引入其他组件
</script>

<style scoped lang="scss">
$primary-color: #4CAF50;
$secondary-color: #f8f9fa;
$accent-color: #FF5722;
$card-bg-color: #fff;
$shadow-color: rgba(0, 0, 0, 0.1);
$header-bg-color: #fff;
$header-text-color: #333;
$gradient-start: #4CAF50;
$gradient-end: #81C784;

.container {
  font-family: 'Poppins', sans-serif;
  background-color: $secondary-color;
  padding: 30px;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.header {
  background-color: $header-bg-color;
  padding: 30px 0;
  text-align: center;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
  border-radius: 10px;
  width: 100%;
  margin-bottom: 40px;
  background: linear-gradient(135deg, $gradient-start, $gradient-end);

  h1 {
    font-size: 3rem;
    color: $header-bg-color;
    margin-bottom: 10px;
    text-transform: uppercase;
    letter-spacing: 2px;
  }

  p {
    font-size: 1.2rem;
    color: $header-bg-color;
    margin-top: 10px;
    font-weight: 300;
  }
}

.stats {
  display: flex;
  justify-content: space-around;
  margin-bottom: 40px;
  width: 100%;
  flex-wrap: wrap;

  .stat-item {
    background-color: $card-bg-color;
    color: $header-text-color;
    border-radius: 12px;
    padding: 30px;
    width: 28%;
    text-align: center;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;

    &:hover {
      transform: translateY(-10px);
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
    }

    h2 {
      font-size: 1.6rem;
      margin-bottom: 10px;
    }

    .count {
      font-size: 2.5rem;
      font-weight: bold;
      letter-spacing: 2px;
      color: $primary-color;
    }
  }
}

.features {
  display: flex;
  justify-content: space-between;
  margin-bottom: 40px;
  width: 100%;
  flex-wrap: wrap;
  gap: 20px;

  .feature-card {
    background-color: $card-bg-color;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    border-radius: 12px;
    padding: 25px;
    width: 30%;
    text-align: center;
    transition: transform 0.3s ease, box-shadow 0.3s ease;

    &:hover {
      transform: translateY(-10px);
      box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
    }

    h3 {
      font-size: 1.6rem;
      color: $primary-color;
      margin-bottom: 10px;
      font-weight: 600;
    }

    p {
      color: #555;
      font-size: 1rem;
      font-weight: 300;
    }
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .stats {
    flex-direction: column;
    align-items: center;
    .stat-item {
      width: 80%;
      margin-bottom: 20px;
    }
  }

  .features {
    flex-direction: column;
    align-items: center;
    .feature-card {
      width: 80%;
      margin-bottom: 20px;
    }
  }

  .header h1 {
    font-size: 2.5rem;
  }

  .header p {
    font-size: 1.1rem;
  }
}

@media (max-width: 480px) {
  .stats {
    .stat-item {
      width: 100%;
    }
  }

  .features {
    .feature-card {
      width: 100%;
    }
  }
}
</style>
