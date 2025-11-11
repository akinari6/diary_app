class CommentsController < ApplicationController
  before_action :set_diary_entry

  def create
    @comment = @diary_entry.comments.build(comment_params)
    @comment.user = Current.user

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @diary_entry, notice: "コメントを投稿しました。" }
      end
    else
      format.html do
        @diary_entry = DiaryEntry.includes(:comments).find(params[:diary_entry_id])
        render "diary_entries/show", status: :unprocessable_entity
      end
    end
  end

  def destroy
    @comment = @diary_entry.comments.find(params[:id])
    if @comment.user == Current.user
      @comment.destroy
      redirect_to @diary_entry, notice: "コメントを削除しました。", status: :see_other
    else
      redirect_to @diary_entry, alert: "他人のコメントは削除できません。", status: :not_found
    end
  end

  private

  def set_diary_entry
    @diary_entry = DiaryEntry.find(params[:diary_entry_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
