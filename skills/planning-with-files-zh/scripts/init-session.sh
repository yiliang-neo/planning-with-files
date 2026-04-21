#!/bin/bash
# 初始化新会话的规划文件
# 用法：./init-session.sh [任务标题]

set -e

TASK_TITLE="${1:-task}"
DATE=$(date +%Y%m%d)

# 将标题中的空格替换为下划线，去除特殊字符
SAFE_TITLE=$(echo "$TASK_TITLE" | tr ' ' '_' | tr -cd '[:alnum:]_一-鿿-')

TASK_PLAN_FILE=".idea/task_plan_${SAFE_TITLE}_${DATE}.md"
FINDINGS_FILE=".idea/findings_${SAFE_TITLE}_${DATE}.md"
PROGRESS_FILE=".idea/progress_${SAFE_TITLE}_${DATE}.md"

# 确保 .idea 目录存在
mkdir -p .idea

echo "正在初始化规划文件：$TASK_TITLE"

# 如果 task_plan 文件不存在则创建
if [ ! -f "$TASK_PLAN_FILE" ]; then
    cat > "$TASK_PLAN_FILE" << 'EOF'
# 任务计划：[简要描述]

## 目标
[用一句话描述最终状态]

## 当前阶段
阶段 1

## 各阶段

### 阶段 1：需求与发现
- [ ] 理解用户意图
- [ ] 确定约束条件和需求
- [ ] 将发现记录到 .idea/findings_*.md
- **状态：** in_progress

### 阶段 2：规划与结构
- [ ] 确定技术方案
- [ ] 如有需要创建项目结构
- [ ] 记录决策及理由
- **状态：** pending

### 阶段 3：实现
- [ ] 按计划逐步执行
- [ ] 先将代码写入文件再执行
- [ ] 增量测试
- **状态：** pending

### 阶段 4：测试与验证
- [ ] 验证所有需求已满足
- [ ] 将测试结果记录到 .idea/progress_*.md
- [ ] 修复发现的问题
- **状态：** pending

### 阶段 5：交付
- [ ] 检查所有输出文件
- [ ] 确保交付物完整
- [ ] 交付给用户
- **状态：** pending

## 已做决策
| 决策 | 理由 |
|------|------|

## 遇到的错误
| 错误 | 解决方案 |
|------|---------|
EOF
    echo "已创建 $TASK_PLAN_FILE"
else
    echo "$TASK_PLAN_FILE 已存在，跳过"
fi

# 如果 findings 文件不存在则创建
if [ ! -f "$FINDINGS_FILE" ]; then
    cat > "$FINDINGS_FILE" << 'EOF'
# 发现与决策

## 需求
-

## 研究发现
-

## 技术决策
| 决策 | 理由 |
|------|------|

## 遇到的问题
| 问题 | 解决方案 |
|------|---------|

## 资源
-
EOF
    echo "已创建 $FINDINGS_FILE"
else
    echo "$FINDINGS_FILE 已存在，跳过"
fi

# 如果 progress 文件不存在则创建
if [ ! -f "$PROGRESS_FILE" ]; then
    cat > "$PROGRESS_FILE" << EOF
# 进度日志

## 会话：$DATE

### 当前状态
- **阶段：** 1 - 需求与发现
- **开始时间：** $DATE

### 已执行操作
-

### 测试结果
| 测试 | 预期 | 实际 | 状态 |
|------|------|------|------|

### 错误
| 错误 | 解决方案 |
|------|---------|
EOF
    echo "已创建 $PROGRESS_FILE"
else
    echo "$PROGRESS_FILE 已存在，跳过"
fi

echo ""
echo "规划文件已初始化！"
echo "目录：.idea/"
echo "文件：$TASK_PLAN_FILE, $FINDINGS_FILE, $PROGRESS_FILE"
