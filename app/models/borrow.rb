class Borrow < ApplicationRecord
  attr_accessor :duree
  # after_create :borrow_asking, :borrow_time_remaining
  after_save :update_book_status, if: :saved_change_to_borrow_status?
  belongs_to :book_copy
  belongs_to :borrower_user, class_name: "User"
  belongs_to :borrowed_user, class_name: "User"

  BORROW_STATUSES = %w[
    pending
    accepted
    declined
    cancelled
    finished
  ].freeze

  BORROW_STATUSES.each do |status_name|
    const_set(status_name.upcase, status_name)
  end

  STATUS_FOR_ABAILABLE_BOOK_COPY = [PENDING, DECLINED, CANCELLED, FINISHED]
  STATUS_FOR_NOT_ABAILABLE_BOOK_COPY = [ACCEPTED]

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_in_the_future
  validate :end_date_after_start_date

  validates :message, presence: true, length: { maximum: 400 }
  validates_inclusion_of :borrow_status, in: BORROW_STATUSES

  validates :borrower_user_id, presence: true
  validates :borrowed_user_id, presence: true
  validates :book_copy_id, presence: true
  validate :borrower_user_is_not_borrowed_user
  validate :user_cant_borrow_a_book_not_available

  private

  def update_book_status
    debugger
    STATUS_FOR_ABAILABLE_BOOK_COPY.include?(borrow_status) ? book_copy.status = BookCopy::AVAILABLE : book_copy.status = BookCopy::NOT_AVAILABLE
    book_copy.save
  end

  def borrow_asking
    UserMailer.borrow_asking_email(self).deliver_now
  end

  def borrow_time_remaining
    duration = (self.end_date - self.start_date) / 3600
    timeremaining1 = 7
    timeremaining2 = 2
    timealert1 = duration - timeremaining1*24
    timealert2 = duration - timeremaining2*24
    UserMailer.borrow_remaining_time_email(self, timeremaining1).deliver_later(wait_until: timealert1.hours.from_now)
    UserMailer.borrow_remaining_time_email(self, timeremaining2).deliver_later(wait_until: timealert2.hours.from_now)
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

  def borrower_user_is_not_borrowed_user
    errors.add(:borrower_user_id, "can't borrow your book") if borrower_user_id == borrowed_user_id
  end

  def user_cant_borrow_a_book_not_available
    if BookCopy.find(book_copy_id).status == BookCopy::NOT_AVAILABLE
        errors.add(:borrower_user_id, "can't borrow this book it's not available")
    end
  end

end
