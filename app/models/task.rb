class Task < ActiveRecord::Base
  TASK_TYPE = ['feature', 'release']
  STATUS_TYPE = ['unstarted', 'started', 'finished']

  acts_as_list

  validates :uuid, presence: true, uniqueness: true, length: {is: 36}
  validates :task_type , inclusion: {in: TASK_TYPE}
  validates :status, inclusion: {in: STATUS_TYPE}
  validates :point, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3}
  validates :title, presence: true
end
