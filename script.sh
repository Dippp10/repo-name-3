#!/bin/bash
# إعدادات الحساب
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

for i in {1..1000}
do
   BRANCH_NAME="batch-update-$i"
   
   # إنشاء فرع جديد
   git checkout -b "$BRANCH_NAME"
   
   # إجراء تغيير وهمي
   echo "Update number $i" >> log.txt
   git add log.txt
   git commit -m "Batch commit $i"
   
   # دفع الفرع وفتح PR ثم دمه
   git push origin "$BRANCH_NAME"
   
   # استخدام GitHub CLI لفتح PR ودمجه تلقائياً
   gh pr create --title "Bulk PR $i" --body "Automated PR #$i" --base main --head "$BRANCH_NAME"
   gh pr merge --merge --delete-branch "$BRANCH_NAME"
   
   # العودة للفرع الرئيسي للبدء من جديد
   git checkout main
done
