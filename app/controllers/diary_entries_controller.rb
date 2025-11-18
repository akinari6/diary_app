class DiaryEntriesController < ApplicationController
  before_action :set_diary, only: [:edit, :update, :destroy]
  def index
    if params[:tag_id].present?
      diary_entries = Current.user.diary_entries.joins(:tags).where(tags: { id: params[:tag_id] })
    else
      diary_entries = Current.user.diary_entries
    end
    @pagy, @diary_entries = pagy(:offset, diary_entries.eager_load(:user, :comments).order(created_at: :desc), limit: 9)
    @tags = Tag.all
  end

  def show
    @diary_entry = Current.user.diary_entries.eager_load(:user, comments: :user).find(params[:id])
    @comment = Comment.new
  end

  def new
    @diary_entry = Current.user.diary_entries.new
  end

  def create
    @diary_entry = Current.user.diary_entries.new(diary_params)
    if @diary_entry.save
      redirect_to @diary_entry, notice: "日記を作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @diary_entry.update(diary_params)
      redirect_to @diary_entry, notice: "日記を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @diary_entry.destroy
    redirect_to diary_entries_path, notice: "日記を削除しました。", status: :see_other
  end

  private

  def set_diary
    @diary_entry = Current.user.diary_entries.find(params[:id])
  end

  def diary_params
    params.require(:diary_entry).permit(:title, :content, tag_ids: [])
  end
end
