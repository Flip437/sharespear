class Borrow < ApplicationRecord
  attr_accessor :duree
  after_create :borrow_asking, :borrow_time_remaining
  belongs_to :book_copy
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_in_the_future
  validate :end_date_after_start_date


  validates :message, presence: true, length: { maximum: 400 }
  validates :borrow_status, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }
  validates :user_id, presence: true
  validates :book_copy_id, presence: true
  validate :user_id_borrow_different_user_id_book_owner
  #validate :user_id_cant_borrow_more_than_10_books_same_time
  validate :user_cant_borrow_a_book_not_available




  private

  def borrow_asking
    #UserMailer.borrow_asking_email(self).deliver_now
  end

  def borrow_time_remaining
    @duration = (self.end_date - self.start_date) / 3600
    @timealert1 = @duration - 7*24
    @timealert2 = @duration - 2*24
    @timeremaining1 = 7
    @timeremaining2 = 2
    #UserMailer.borrow_remaining_time_email(self, @timeremaining1).deliver_later(wait_until: @timealert1.hours.from_now)
    #UserMailer.borrow_remaining_time_email(self, @timeremaining2).deliver_later(wait_until: @timealert2.hours.from_now)
    #UserMailer.borrow_remaining_time_email(self, @timeremaining1).deliver_now
    #UserMailer.borrow_remaining_time_email(self, @timeremaining2).deliver_now
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def start_date_in_the_future

    if end_date < DateTime.now
      errors.add(:end_date, "must be in the future")
    end

    if start_date > DateTime.now
      errors.add(:start_date, "must be in the future")
    end

  end

  def user_id_borrow_different_user_id_book_owner
    if user_id == BookCopy.find(book_copy_id).user_id
        errors.add(:user_id, "can't borrow your book")
    end
  end

  def user_cant_borrow_a_book_not_available
    if BookCopy.find(book_copy_id).status == false
        errors.add(:user_id, "can't borrow this book it's not available")
    end
  end

end
